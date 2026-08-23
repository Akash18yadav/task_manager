import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller/auth_controller.dart';
import 'package:task_manager/controller/task_controller.dart';



class TaskDetailScreen
    extends StatefulWidget {
  const TaskDetailScreen({
    super.key,
  });

  @override
  State<TaskDetailScreen> createState() {
    return _TaskDetailScreenState();
  }
}

class _TaskDetailScreenState
    extends State<TaskDetailScreen> {
  final taskController =
      Get.find<TaskController>();

  final authController =
      Get.find<AuthController>();

  late final String taskId;

  @override
  void initState() {
    super.initState();

    taskId = Get.arguments as String;

    Future.microtask(() {
      taskController.loadTaskDetails(
        taskId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Task Details'),
        actions: [
          Obx(() {
            final task =
                taskController
                    .selectedTask.value;

            if (task == null) {
              return const SizedBox();
            }

            return IconButton(
              icon:
                  const Icon(Icons.edit),
              onPressed: () {
                Get.toNamed(
                  '/task-form',
                  arguments: {
                    'projectId':
                        task.projectId,
                    'task': task,
                  },
                );
              },
            );
          }),

          Obx(() {
            final task =
                taskController
                    .selectedTask.value;

            if (task == null) {
              return const SizedBox();
            }

            final canDelete =
                authController.isAdmin ||
                    task.assigneeId ==
                        authController
                            .currentUserId;

            if (!canDelete) {
              return const SizedBox();
            }

            return IconButton(
              icon:
                  const Icon(Icons.delete),
              onPressed:
                  _showDeleteDialog,
            );
          }),
        ],
      ),

      body: Obx(() {
        final task =
            taskController
                .selectedTask.value;

        if (task == null) {
          return const Center(
            child:
                CircularProgressIndicator(),
          );
        }

        return SingleChildScrollView(
          padding:
              const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                task.title,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              Text(
                task.description ??
                    'No description',
              ),

              const SizedBox(height: 24),

              _buildInfoRow(
                'Priority',
                task.priority.toUpperCase(),
              ),

              const SizedBox(height: 12),

              _buildStatusDropdown(task),

              const SizedBox(height: 12),

              _buildInfoRow(
                'Due Date',
                task.dueDate == null
                    ? 'Not set'
                    : task.dueDate!
                        .toString()
                        .split(' ')
                        .first,
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildInfoRow(
    String label,
    String value,
  ) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: const TextStyle(
            fontWeight:
                FontWeight.bold,
          ),
        ),
        Expanded(
          child: Text(value),
        ),
      ],
    );
  }

  Widget _buildStatusDropdown(
    dynamic task,
  ) {
    return Row(
      children: [
        const Text(
          'Status: ',
          style: TextStyle(
            fontWeight:
                FontWeight.bold,
          ),
        ),

        Expanded(
          child:
              DropdownButton<String>(
            value: task.status,
            isExpanded: true,
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
                taskController
                    .updateTaskStatus(
                  task: task,
                  status: value,
                );
              }
            },
          ),
        ),
      ],
    );
  }

  void _showDeleteDialog() {
    Get.defaultDialog(
      title: 'Delete Task',
      middleText:
          'Are you sure you want to delete this task?',
      textCancel: 'Cancel',
      textConfirm: 'Delete',
      confirmTextColor:
          Colors.white,
      onConfirm: () {
        taskController.deleteTask(
          taskId: taskId,
          userId:
              authController.currentUserId,
          organizationId:
              authController
                  .currentOrganizationId,
        );
      },
    );
  }
}