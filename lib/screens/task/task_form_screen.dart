import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller/auth_controller.dart';
import 'package:task_manager/controller/task_controller.dart';

import '../../../data/models/task_model.dart';


class TaskFormScreen
    extends StatefulWidget {
  const TaskFormScreen({
    super.key,
  });

  @override
  State<TaskFormScreen> createState() {
    return _TaskFormScreenState();
  }
}

class _TaskFormScreenState
    extends State<TaskFormScreen> {
  final formKey =
      GlobalKey<FormState>();

  final titleController =
      TextEditingController();

  final descriptionController =
      TextEditingController();

  final taskController =
      Get.find<TaskController>();

  final authController =
      Get.find<AuthController>();

  String priority = 'medium';

  String status = 'todo';

  DateTime? selectedDueDate;

  TaskModel? editingTask;

  late final String projectId;

  @override
  void initState() {
    super.initState();

    final arguments =
        Get.arguments as Map<String, dynamic>;

    projectId =
        arguments['projectId'] as String;

    editingTask =
        arguments['task'] as TaskModel?;

    if (editingTask != null) {
      titleController.text =
          editingTask!.title;

      descriptionController.text =
          editingTask!.description ?? '';

      priority =
          editingTask!.priority;

      status =
          editingTask!.status;

      selectedDueDate =
          editingTask!.dueDate;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing =
        editingTask != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing
              ? 'Edit Task'
              : 'Create Task',
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller:
                      titleController,
                  decoration:
                      const InputDecoration(
                    labelText: 'Task Title',
                    border:
                        OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return 'Task title is required';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16),

                TextFormField(
                  controller:
                      descriptionController,
                  maxLines: 4,
                  decoration:
                      const InputDecoration(
                    labelText: 'Description',
                    border:
                        OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 16),

                DropdownButtonFormField<String>(
                  value: priority,
                  decoration:
                      const InputDecoration(
                    labelText: 'Priority',
                    border:
                        OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'high',
                      child: Text('High'),
                    ),
                    DropdownMenuItem(
                      value: 'medium',
                      child: Text('Medium'),
                    ),
                    DropdownMenuItem(
                      value: 'low',
                      child: Text('Low'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        priority = value;
                      });
                    }
                  },
                ),

                const SizedBox(height: 16),

                if (isEditing)
                  DropdownButtonFormField<String>(
                    value: status,
                    decoration:
                        const InputDecoration(
                      labelText: 'Status',
                      border:
                          OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'todo',
                        child: Text('To Do'),
                      ),
                      DropdownMenuItem(
                        value: 'in_progress',
                        child:
                            Text('In Progress'),
                      ),
                      DropdownMenuItem(
                        value: 'completed',
                        child:
                            Text('Completed'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          status = value;
                        });
                      }
                    },
                  ),

                if (isEditing)
                  const SizedBox(height: 16),

                OutlinedButton.icon(
                  onPressed: _selectDueDate,
                  icon:
                      const Icon(Icons.calendar_today),
                  label: Text(
                    selectedDueDate == null
                        ? 'Select Due Date'
                        : selectedDueDate
                            .toString()
                            .split(' ')
                            .first,
                  ),
                ),

                const SizedBox(height: 30),

                SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _submitTask,
                    child: Text(
                      isEditing
                          ? 'Update Task'
                          : 'Create Task',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDueDate() async {
    final date =
        await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      initialDate:
          selectedDueDate ?? DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      setState(() {
        selectedDueDate = date;
      });
    }
  }

  void _submitTask() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (editingTask != null) {
      taskController.updateTask(
        task: editingTask!,
        title:
            titleController.text.trim(),
        description:
            descriptionController.text
                    .trim()
                    .isEmpty
                ? null
                : descriptionController.text
                    .trim(),
        status: status,
        priority: priority,
        assigneeId:
            editingTask!.assigneeId,
        dueDate: selectedDueDate,
      );
    } else {
      taskController.createTask(
        projectId: projectId,
        organizationId:
            authController
                .currentOrganizationId,
        title:
            titleController.text.trim(),
        description:
            descriptionController.text
                    .trim()
                    .isEmpty
                ? null
                : descriptionController.text
                    .trim(),
        priority: priority,
        dueDate: selectedDueDate,
      );
    }
  }
}