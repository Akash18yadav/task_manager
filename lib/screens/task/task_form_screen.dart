// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:task_manager/controller/auth_controller.dart';
// import 'package:task_manager/controller/task_controller.dart';

// import '../../../data/models/task_model.dart';


// class TaskFormScreen
//     extends StatefulWidget {
//   const TaskFormScreen({
//     super.key,
//   });

//   @override
//   State<TaskFormScreen> createState() {
//     return _TaskFormScreenState();
//   }
// }

// class _TaskFormScreenState
//     extends State<TaskFormScreen> {
//   final formKey =
//       GlobalKey<FormState>();
//         final taskController =
//       Get.find<TaskController>();

//   final titleController =
//       TextEditingController();

//   final descriptionController =
//       TextEditingController();

 

//   final authController =
//       Get.find<AuthController>();

//   String priority = 'medium';

//   String status = 'todo';

//   DateTime? selectedDueDate;

//   TaskModel? editingTask;

//   late final String projectId;

//   @override
//   void initState() {
//     super.initState();

//     final arguments =
//         Get.arguments as Map<String, dynamic>;

//     projectId =
//         arguments['projectId'] as String;

//     editingTask =
//         arguments['task'] as TaskModel?;

//     if (editingTask != null) {
//       titleController.text =
//           editingTask!.title;

//       descriptionController.text =
//           editingTask!.description ?? '';

//       priority =
//           editingTask!.priority;

//       status =
//           editingTask!.status;

//       selectedDueDate =
//           editingTask!.dueDate;
//     }
//   }

//   @override
//   void dispose() {
//     titleController.dispose();
//     descriptionController.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isEditing =
//         editingTask != null;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           isEditing
//               ? 'Edit Task'
//               : 'Create Task',
//         ),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding:
//               const EdgeInsets.all(20),
//           child: Form(
//             key: formKey,
//             child: Column(
//               crossAxisAlignment:
//                   CrossAxisAlignment.stretch,
//               children: [
//                 TextFormField(
//                   controller:
//                       titleController,
//                   decoration:
//                       const InputDecoration(
//                     labelText: 'Task Title',
//                     border:
//                         OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null ||
//                         value.trim().isEmpty) {
//                       return 'Task title is required';
//                     }

//                     return null;
//                   },
//                 ),

//                 const SizedBox(height: 16),

//                 TextFormField(
//                   controller:
//                       descriptionController,
//                   maxLines: 4,
//                   decoration:
//                       const InputDecoration(
//                     labelText: 'Description',
//                     border:
//                         OutlineInputBorder(),
//                   ),
//                 ),

//                 const SizedBox(height: 16),

//                 DropdownButtonFormField<String>(
//                   value: priority,
//                   decoration:
//                       const InputDecoration(
//                     labelText: 'Priority',
//                     border:
//                         OutlineInputBorder(),
//                   ),
//                   items: const [
//                     DropdownMenuItem(
//                       value: 'high',
//                       child: Text('High'),
//                     ),
//                     DropdownMenuItem(
//                       value: 'medium',
//                       child: Text('Medium'),
//                     ),
//                     DropdownMenuItem(
//                       value: 'low',
//                       child: Text('Low'),
//                     ),
//                   ],
//                   onChanged: (value) {
//                     if (value != null) {
//                       setState(() {
//                         priority = value;
//                       });
//                     }
//                   },
//                 ),

//                 const SizedBox(height: 16),

//                 if (isEditing)
//                   DropdownButtonFormField<String>(
//                     value: status,
//                     decoration:
//                         const InputDecoration(
//                       labelText: 'Status',
//                       border:
//                           OutlineInputBorder(),
//                     ),
//                     items: const [
//                       DropdownMenuItem(
//                         value: 'todo',
//                         child: Text('To Do'),
//                       ),
//                       DropdownMenuItem(
//                         value: 'in_progress',
//                         child:
//                             Text('In Progress'),
//                       ),
//                       DropdownMenuItem(
//                         value: 'completed',
//                         child:
//                             Text('Completed'),
//                       ),
//                     ],
//                     onChanged: (value) {
//                       if (value != null) {
//                         setState(() {
//                           status = value;
//                         });
//                       }
//                     },
//                   ),

//                 if (isEditing)
//                   const SizedBox(height: 16),

//                 OutlinedButton.icon(
//                   onPressed: _selectDueDate,
//                   icon:
//                       const Icon(Icons.calendar_today),
//                   label: Text(
//                     selectedDueDate == null
//                         ? 'Select Due Date'
//                         : selectedDueDate
//                             .toString()
//                             .split(' ')
//                             .first,
//                   ),
//                 ),

//                 const SizedBox(height: 30),

//                 SizedBox(
//                   height: 52,
//                   child: ElevatedButton(
//                     onPressed: _submitTask,
//                     child: Text(
//                       isEditing
//                           ? 'Update Task'
//                           : 'Create Task',
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _selectDueDate() async {
//     final date =
//         await showDatePicker(
//       context: context,
//       firstDate: DateTime.now(),
//       initialDate:
//           selectedDueDate ?? DateTime.now(),
//       lastDate: DateTime(2100),
//     );

//     if (date != null) {
//       setState(() {
//         selectedDueDate = date;
//       });
//     }
//   }

//   void _submitTask() {
//     if (!formKey.currentState!.validate()) {
//       return;
//     }

//     if (editingTask != null) {
//       taskController.updateTask(
//         task: editingTask!,
//         title:
//             titleController.text.trim(),
//         description:
//             descriptionController.text
//                     .trim()
//                     .isEmpty
//                 ? null
//                 : descriptionController.text
//                     .trim(),
//         status: status,
//         priority: priority,
//         assigneeId:
//             editingTask!.assigneeId,
//         dueDate: selectedDueDate,
//       );
//     } else {
//       taskController.createTask(
//         projectId: projectId,
//         organizationId:
//             authController
//                 .currentOrganizationId,
//         title:
//             titleController.text.trim(),
//         description:
//             descriptionController.text
//                     .trim()
//                     .isEmpty
//                 ? null
//                 : descriptionController.text
//                     .trim(),
//         priority: priority,
//         dueDate: selectedDueDate,
//       );
//     }
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller/auth_controller.dart';
import 'package:task_manager/controller/task_controller.dart';

import '../../../data/models/task_model.dart';

class TaskFormScreen extends StatefulWidget {
  const TaskFormScreen({
    super.key,
  });

  @override
  State<TaskFormScreen> createState() {
    return _TaskFormScreenState();
  }
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  final formKey = GlobalKey<FormState>();

  final taskController = Get.find<TaskController>();

  final titleController = TextEditingController();

  final descriptionController = TextEditingController();

  final authController = Get.find<AuthController>();

  String priority = 'medium';

  String status = 'todo';

  DateTime? selectedDueDate;

  TaskModel? editingTask;

  late final String projectId;

  static const Color backgroundColor = Color(0xFF0B0D1C);
  static const Color cardColor = Color(0xFF15182B);
  static const Color fieldColor = Color(0xFF111426);
  static const Color purpleColor = Color(0xFF8B5CF6);
  static const Color purpleDark = Color(0xFF5B4FCF);
  static const Color lightPurple = Color(0xFFB794F6);
  static const Color textColor = Color(0xFFF4F4F8);
  static const Color subTextColor = Color(0xFFA7A9B8);

  @override
  void initState() {
    super.initState();

    final arguments = Get.arguments as Map<String, dynamic>;

    projectId = arguments['projectId'] as String;

    editingTask = arguments['task'] as TaskModel?;

    if (editingTask != null) {
      titleController.text = editingTask!.title;

      descriptionController.text =
          editingTask!.description ?? '';

      priority = editingTask!.priority;

      status = editingTask!.status;

      selectedDueDate = editingTask!.dueDate;
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
    final isEditing = editingTask != null;

    return Scaffold(
      backgroundColor: backgroundColor,

      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,

        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: textColor,
            size: 20,
          ),
        ),

        title: Text(
          isEditing ? 'Edit Task' : 'Create Task',
          style: const TextStyle(
            color: textColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: Stack(
        children: [
          /// Background Decoration
          Positioned(
            top: -100,
            right: -80,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: purpleColor.withOpacity(0.07),
              ),
            ),
          ),

          Positioned(
            bottom: -60,
            left: -70,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: purpleColor.withOpacity(0.05),
              ),
            ),
          ),

          SafeArea(
            top: false,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                20,
                16,
                20,
                30,
              ),

              child: Form(
                key: formKey,

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    /// Header
                    Row(
                      children: [
                        Container(
                          width: 58,
                          height: 58,

                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                purpleColor,
                                purpleDark,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),

                            borderRadius:
                                BorderRadius.circular(18),

                            boxShadow: [
                              BoxShadow(
                                color: purpleColor
                                    .withOpacity(0.25),
                                blurRadius: 18,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),

                          child: Icon(
                            isEditing
                                ? Icons.edit_rounded
                                : Icons.add_task_rounded,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),

                        const SizedBox(width: 16),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                isEditing
                                    ? 'Update your task'
                                    : 'Create a new task',
                                style: const TextStyle(
                                  color: textColor,
                                  fontSize: 20,
                                  fontWeight:
                                      FontWeight.w700,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                isEditing
                                    ? 'Modify task details below'
                                    : 'Add details to organize your work',
                                style: const TextStyle(
                                  color: subTextColor,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    /// Form Card
                    Container(
                      width: double.infinity,

                      padding: const EdgeInsets.all(20),

                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius:
                            BorderRadius.circular(24),

                        border: Border.all(
                          color:
                              Colors.white.withOpacity(0.06),
                        ),

                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.black.withOpacity(0.18),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),

                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [
                          const Text(
                            'TASK DETAILS',
                            style: TextStyle(
                              color: lightPurple,
                              fontSize: 11,
                              fontWeight:
                                  FontWeight.w700,
                              letterSpacing: 1.2,
                            ),
                          ),

                          const SizedBox(height: 20),

                          /// Task Title
                          _buildLabel(
                            icon: Icons.title_rounded,
                            label: 'Task Title',
                          ),

                          const SizedBox(height: 10),

                          TextFormField(
                            controller: titleController,

                            style: const TextStyle(
                              color: textColor,
                            ),

                            cursorColor: purpleColor,

                            decoration: _inputDecoration(
                              hint: 'Enter task title',
                              icon: Icons.edit_note_rounded,
                            ),

                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty) {
                                return 'Task title is required';
                              }

                              return null;
                            },
                          ),

                          const SizedBox(height: 22),

                          /// Description
                          _buildLabel(
                            icon: Icons.description_outlined,
                            label: 'Description',
                          ),

                          const SizedBox(height: 10),

                          TextFormField(
                            controller: descriptionController,

                            maxLines: 4,

                            style: const TextStyle(
                              color: textColor,
                            ),

                            cursorColor: purpleColor,

                            decoration: _inputDecoration(
                              hint:
                                  'Describe what needs to be done...',
                              icon: Icons.notes_rounded,
                            ),
                          ),

                          const SizedBox(height: 22),

                          /// Priority
                          _buildLabel(
                            icon: Icons.flag_outlined,
                            label: 'Priority',
                          ),

                          const SizedBox(height: 10),

                          DropdownButtonFormField<String>(
                            value: priority,

                            dropdownColor: cardColor,

                            style: const TextStyle(
                              color: textColor,
                              fontSize: 15,
                            ),

                            icon: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: lightPurple,
                            ),

                            decoration: _inputDecoration(
                              hint: '',
                              icon: Icons.flag_rounded,
                            ),

                            items: const [
                              DropdownMenuItem(
                                value: 'high',
                                child: Text(
                                  'High',
                                  style: TextStyle(
                                    color: textColor,
                                  ),
                                ),
                              ),

                              DropdownMenuItem(
                                value: 'medium',
                                child: Text(
                                  'Medium',
                                  style: TextStyle(
                                    color: textColor,
                                  ),
                                ),
                              ),

                              DropdownMenuItem(
                                value: 'low',
                                child: Text(
                                  'Low',
                                  style: TextStyle(
                                    color: textColor,
                                  ),
                                ),
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

                          /// Status only for editing
                          if (isEditing) ...[
                            const SizedBox(height: 22),

                            _buildLabel(
                              icon: Icons.sync_rounded,
                              label: 'Status',
                            ),

                            const SizedBox(height: 10),

                            DropdownButtonFormField<String>(
                              value: status,

                              dropdownColor: cardColor,

                              style: const TextStyle(
                                color: textColor,
                                fontSize: 15,
                              ),

                              icon: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: lightPurple,
                              ),

                              decoration: _inputDecoration(
                                hint: '',
                                icon: Icons.track_changes_rounded,
                              ),

                              items: const [
                                DropdownMenuItem(
                                  value: 'todo',
                                  child: Text(
                                    'To Do',
                                    style: TextStyle(
                                      color: textColor,
                                    ),
                                  ),
                                ),

                                DropdownMenuItem(
                                  value: 'in_progress',
                                  child: Text(
                                    'In Progress',
                                    style: TextStyle(
                                      color: textColor,
                                    ),
                                  ),
                                ),

                                DropdownMenuItem(
                                  value: 'completed',
                                  child: Text(
                                    'Completed',
                                    style: TextStyle(
                                      color: textColor,
                                    ),
                                  ),
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
                          ],

                          const SizedBox(height: 22),

                          /// Due Date
                          _buildLabel(
                            icon: Icons.calendar_month_outlined,
                            label: 'Due Date',
                          ),

                          const SizedBox(height: 10),

                          InkWell(
                            onTap: _selectDueDate,

                            borderRadius:
                                BorderRadius.circular(16),

                            child: Container(
                              width: double.infinity,
                              padding:
                                  const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 17,
                              ),

                              decoration: BoxDecoration(
                                color: fieldColor,
                                borderRadius:
                                    BorderRadius.circular(16),

                                border: Border.all(
                                  color: Colors.white
                                      .withOpacity(0.08),
                                ),
                              ),

                              child: Row(
                                children: [
                                  Container(
                                    width: 38,
                                    height: 38,

                                    decoration: BoxDecoration(
                                      color: purpleColor
                                          .withOpacity(0.12),
                                      borderRadius:
                                          BorderRadius.circular(10),
                                    ),

                                    child: const Icon(
                                      Icons.calendar_today_rounded,
                                      color: lightPurple,
                                      size: 19,
                                    ),
                                  ),

                                  const SizedBox(width: 14),

                                  Expanded(
                                    child: Text(
                                      selectedDueDate == null
                                          ? 'Select due date'
                                          : selectedDueDate
                                              .toString()
                                              .split(' ')
                                              .first,

                                      style: TextStyle(
                                        color:
                                            selectedDueDate == null
                                                ? subTextColor
                                                : textColor,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),

                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: lightPurple,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    /// Submit Button
                    InkWell(
                      borderRadius:
                          BorderRadius.circular(18),

                      onTap: _submitTask,

                      child: Ink(
                        width: double.infinity,
                        height: 58,

                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              purpleColor,
                              purpleDark,
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),

                          borderRadius:
                              BorderRadius.circular(18),

                          boxShadow: [
                            BoxShadow(
                              color:
                                  purpleColor.withOpacity(0.30),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),

                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isEditing
                                    ? Icons.save_rounded
                                    : Icons.add_task_rounded,
                                color: Colors.white,
                              ),

                              const SizedBox(width: 10),

                              Text(
                                isEditing
                                    ? 'Update Task'
                                    : 'Create Task',

                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight:
                                      FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel({
    required IconData icon,
    required String label,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: lightPurple,
          size: 18,
        ),

        const SizedBox(width: 8),

        Text(
          label,
          style: const TextStyle(
            color: textColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hint,

      hintStyle: const TextStyle(
        color: subTextColor,
        fontSize: 14,
      ),

      prefixIcon: Icon(
        icon,
        color: lightPurple,
      ),

      filled: true,

      fillColor: fieldColor,

      contentPadding:
          const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 17,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),

        borderSide: BorderSide(
          color: Colors.white.withOpacity(0.08),
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),

        borderSide: const BorderSide(
          color: purpleColor,
          width: 1.5,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),

        borderSide: const BorderSide(
          color: Colors.redAccent,
        ),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),

        borderSide: const BorderSide(
          color: Colors.redAccent,
          width: 1.5,
        ),
      ),
    );
  }

  Future<void> _selectDueDate() async {
    final date = await showDatePicker(
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

        title: titleController.text.trim(),

        description:
            descriptionController.text.trim().isEmpty
                ? null
                : descriptionController.text.trim(),

        status: status,

        priority: priority,

        assigneeId: editingTask!.assigneeId,

        dueDate: selectedDueDate,
      );
    } else {
      taskController.createTask(
        projectId: projectId,

        organizationId:
            authController.currentOrganizationId,

        title: titleController.text.trim(),

        description:
            descriptionController.text.trim().isEmpty
                ? null
                : descriptionController.text.trim(),

        priority: priority,

        dueDate: selectedDueDate,
      );
    }
  }
}