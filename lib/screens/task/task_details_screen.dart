// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:task_manager/controller/auth_controller.dart';
// import 'package:task_manager/controller/task_controller.dart';



// class TaskDetailScreen
//     extends StatefulWidget {
//   const TaskDetailScreen({
//     super.key,
//   });

//   @override
//   State<TaskDetailScreen> createState() {
//     return _TaskDetailScreenState();
//   }
// }

// class _TaskDetailScreenState
//     extends State<TaskDetailScreen> {
//         String selectedStatus = 'todo';
//   final taskController =
//       Get.find<TaskController>();

//   final authController =
//       Get.find<AuthController>();

//   late final String taskId;

//   @override
//   void initState() {
//     super.initState();

//     taskId = Get.arguments as String;

//     Future.microtask(() {
//       taskController.loadTaskDetails(
//         taskId,
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title:
//             const Text('Task Details'),
//         actions: [
//           Obx(() {
//             final task =
//                 taskController
//                     .selectedTask.value;

//             if (task == null) {
//               return const SizedBox();
//             }

//             return IconButton(
//               icon:
//                   const Icon(Icons.edit),
//               onPressed: () {
//                 Get.toNamed(
//                   '/task-form',
//                   arguments: {
//                     'projectId':
//                         task.projectId,
//                     'task': task,
//                   },
//                 );
//               },
//             );
//           }),

//           Obx(() {
//             final task =
//                 taskController
//                     .selectedTask.value;

//             if (task == null) {
//               return const SizedBox();
//             }

//             final canDelete =
//                 authController.isAdmin ||
//                     task.assigneeId ==
//                         authController
//                             .currentUserId;

//             if (!canDelete) {
//               return const SizedBox();
//             }

//             return IconButton(
//               icon:
//                   const Icon(Icons.delete),
//               onPressed:
//                   _showDeleteDialog,
//             );
//           }),
//         ],
//       ),

//       body: Obx(() {
//         final task =
//             taskController
//                 .selectedTask.value;

//         if (task == null) {
//           return const Center(
//             child:
//                 CircularProgressIndicator(),
//           );
//         }

//         return SingleChildScrollView(
//           padding:
//               const EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment:
//                 CrossAxisAlignment.start,
//             children: [
//               Text(
//                 task.title,
//                 style: const TextStyle(
//                   fontSize: 26,
//                   fontWeight:
//                       FontWeight.bold,
//                 ),
//               ),

//               const SizedBox(height: 16),

//               Text(
//                 task.description ??
//                     'No description',
//               ),

//               const SizedBox(height: 24),

//               _buildInfoRow(
//                 'Priority',
//                 task.priority.toUpperCase(),
//               ),

//               const SizedBox(height: 12),

//               _buildStatusDropdown(task),

//               const SizedBox(height: 12),

//               _buildInfoRow(
//                 'Due Date',
//                 task.dueDate == null
//                     ? 'Not set'
//                     : task.dueDate!
//                         .toString()
//                         .split(' ')
//                         .first,
//               ),
//             ],
//           ),
//         );
//       }),
//     );
//   }

//   Widget _buildInfoRow(
//     String label,
//     String value,
//   ) {
//     return Row(
//       children: [
//         Text(
//           '$label: ',
//           style: const TextStyle(
//             fontWeight:
//                 FontWeight.bold,
//           ),
//         ),
//         Expanded(
//           child: Text(value),
//         ),
//       ],
//     );
//   }

//   Widget _buildStatusDropdown(
//     dynamic task,
//   ) {
//     return Row(
//       children: [
//         const Text(
//           'Status: ',
//           style: TextStyle(
//             fontWeight:
//                 FontWeight.bold,
//           ),
//         ),

//         Expanded(
//           child:
//           //     DropdownButton<String>(
//           //   value: task.status,
//           //   isExpanded: true,
//           //   items: const [
//           //     DropdownMenuItem(
//           //       value: 'todo',
//           //       child: Text('To Do'),
//           //     ),
//           //     DropdownMenuItem(
//           //       value: 'in_progress',
//           //       child:
//           //           Text('In Progress'),
//           //     ),
//           //     DropdownMenuItem(
//           //       value: 'completed',
//           //       child:
//           //           Text('Completed'),
//           //     ),
//           //   ],
//           //   onChanged: (value) {
//           //     if (value != null) {
//           //       taskController
//           //           .updateTaskStatus(
//           //         task: task,
//           //         status: value,
//           //       );
//           //     }
//           //   },
//           // ),
//           DropdownButton<String>(
//   value: selectedStatus,
//   isExpanded: true,
//   items: const [
//     DropdownMenuItem(
//       value: 'todo',
//       child: Text('To Do'),
//     ),
//     DropdownMenuItem(
//       value: 'in_progress',
//       child: Text('In Progress'),
//     ),
//     DropdownMenuItem(
//       value: 'review',
//       child: Text('Review'),
//     ),
//     DropdownMenuItem(
//       value: 'done',
//       child: Text('Done'),
//     ),
//   ],
//   onChanged: (value) {
//     if (value != null) {
//       setState(() {
//         selectedStatus = value;
//       });
//     }
//   },
// )
//         ),
//       ],
//     );
//   }

//   void _showDeleteDialog() {
//     Get.defaultDialog(
//       title: 'Delete Task',
//       middleText:
//           'Are you sure you want to delete this task?',
//       textCancel: 'Cancel',
//       textConfirm: 'Delete',
//       confirmTextColor:
//           Colors.white,
//       onConfirm: () {
//         taskController.deleteTask(
//           taskId: taskId,
//           userId:
//               authController.currentUserId,
//           organizationId:
//               authController
//                   .currentOrganizationId,
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller/auth_controller.dart';
import 'package:task_manager/controller/task_controller.dart';

class TaskDetailScreen extends StatefulWidget {
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
  String selectedStatus = 'todo';

  final taskController =
      Get.find<TaskController>();

  final authController =
      Get.find<AuthController>();

  late final String taskId;

  @override
  void initState() {
    super.initState();

    taskId = Get.arguments as String;

    Future.microtask(() async {
      await taskController.loadTaskDetails(
        taskId,
      );

      final task =
          taskController.selectedTask.value;

      if (task != null && mounted) {
        setState(() {
          selectedStatus = task.status;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor =
        Color(0xFF6C4ED9);

    const backgroundColor =
        Color(0xFFF7F7FB);

    return Scaffold(
      backgroundColor: backgroundColor,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF25252D),
            size: 20,
          ),
          onPressed: () {
            Get.back();
          },
        ),

        title: const Text(
          'Task Details',
          style: TextStyle(
            color: Color(0xFF25252D),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),

        centerTitle: false,

        actions: [
          Obx(() {
            final task =
                taskController.selectedTask.value;

            if (task == null) {
              return const SizedBox();
            }

            return Container(
              margin:
                  const EdgeInsets.only(right: 4),

              decoration: BoxDecoration(
                color: const Color(0xFFF0ECFF),
                borderRadius:
                    BorderRadius.circular(12),
              ),

              child: IconButton(
                icon: const Icon(
                  Icons.edit_outlined,
                  color: primaryColor,
                ),

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
              ),
            );
          }),

          const SizedBox(width: 8),

          Obx(() {
            final task =
                taskController.selectedTask.value;

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

            return Container(
              margin:
                  const EdgeInsets.only(right: 16),

              decoration: BoxDecoration(
                color: const Color(0xFFFFEEEE),
                borderRadius:
                    BorderRadius.circular(12),
              ),

              child: IconButton(
                icon: const Icon(
                  Icons.delete_outline_rounded,
                  color: Color(0xFFE05252),
                ),

                onPressed:
                    _showDeleteDialog,
              ),
            );
          }),
        ],
      ),

      body: Obx(() {
        final task =
            taskController.selectedTask.value;

        if (task == null) {
          return const Center(
            child:
                CircularProgressIndicator(
              color: primaryColor,
            ),
          );
        }

        return SingleChildScrollView(
          padding:
              const EdgeInsets.fromLTRB(
            20,
            24,
            20,
            30,
          ),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              /// PRIORITY BADGE
              Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),

                decoration: BoxDecoration(
                  color:
                      _getPriorityColor(
                    task.priority,
                  ).withOpacity(0.12),

                  borderRadius:
                      BorderRadius.circular(20),
                ),

                child: Text(
                  '${task.priority.toUpperCase()} PRIORITY',

                  style: TextStyle(
                    color:
                        _getPriorityColor(
                      task.priority,
                    ),

                    fontSize: 12,
                    fontWeight:
                        FontWeight.w700,

                    letterSpacing: 0.5,
                  ),
                ),
              ),

              const SizedBox(height: 18),

              /// TASK TITLE
              Text(
                task.title,

                style: const TextStyle(
                  fontSize: 28,
                  fontWeight:
                      FontWeight.w700,

                  color:
                      Color(0xFF24242D),

                  height: 1.25,
                ),
              ),

              const SizedBox(height: 14),

              /// DESCRIPTION
              Text(
                task.description ??
                    'No description available.',

                style: const TextStyle(
                  fontSize: 15,
                  color:
                      Color(0xFF6E6E7A),

                  height: 1.6,
                ),
              ),

              const SizedBox(height: 28),

              /// DETAILS CARD
              Container(
                width: double.infinity,

                padding:
                    const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius:
                      BorderRadius.circular(20),

                  border: Border.all(
                    color:
                        const Color(0xFFE9E7F0),
                  ),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withOpacity(0.03),

                      blurRadius: 18,

                      offset:
                          const Offset(0, 6),
                    ),
                  ],
                ),

                child: Column(
                  children: [
                    _buildInfoTile(
                      icon:
                          Icons.flag_outlined,

                      iconColor:
                          _getPriorityColor(
                        task.priority,
                      ),

                      title: 'Priority',

                      child: Text(
                        _formatText(
                          task.priority,
                        ),

                        style:
                            const TextStyle(
                          fontSize: 15,

                          fontWeight:
                              FontWeight.w600,

                          color:
                              Color(0xFF30303A),
                        ),
                      ),
                    ),

                    const Divider(
                      height: 28,
                      color:
                          Color(0xFFEDEBF2),
                    ),

                    _buildInfoTile(
                      icon:
                          Icons
                              .check_circle_outline_rounded,

                      iconColor:
                          primaryColor,

                      title: 'Status',

                      child:
                          _buildStatusDropdown(
                        task,
                      ),
                    ),

                    const Divider(
                      height: 28,
                      color:
                          Color(0xFFEDEBF2),
                    ),

                    _buildInfoTile(
                      icon:
                          Icons.calendar_today_outlined,

                      iconColor:
                          const Color(
                        0xFF4C8BF5,
                      ),

                      title: 'Due Date',

                      child: Text(
                        task.dueDate == null
                            ? 'Not set'
                            : task
                                .dueDate!
                                .toString()
                                .split(' ')
                                .first,

                        style:
                            const TextStyle(
                          fontSize: 15,

                          fontWeight:
                              FontWeight.w600,

                          color:
                              Color(0xFF30303A),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              /// QUICK INFO
              const Text(
                'Task Information',

                style: TextStyle(
                  fontSize: 18,
                  fontWeight:
                      FontWeight.w700,

                  color:
                      Color(0xFF25252D),
                ),
              ),

              const SizedBox(height: 12),

              Container(
                width: double.infinity,

                padding:
                    const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color:
                      const Color(0xFFF0ECFF),

                  borderRadius:
                      BorderRadius.circular(16),
                ),

                child: Row(
                  children: [
                    const Icon(
                      Icons.lightbulb_outline,
                      color: primaryColor,
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Text(
                        'Keep your task status updated to track project progress easily.',

                        style:
                            const TextStyle(
                          fontSize: 13,

                          color:
                              Color(0xFF625B7A),

                          height: 1.45,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required Widget child,
  }) {
    return Row(
      children: [
        Container(
          height: 42,
          width: 42,

          decoration: BoxDecoration(
            color:
                iconColor.withOpacity(0.10),

            borderRadius:
                BorderRadius.circular(12),
          ),

          child: Icon(
            icon,
            color: iconColor,
            size: 21,
          ),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              Text(
                title,

                style: const TextStyle(
                  fontSize: 12,

                  color:
                      Color(0xFF8A8895),

                  fontWeight:
                      FontWeight.w500,
                ),
              ),

              const SizedBox(height: 4),

              child,
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusDropdown(
    dynamic task,
  ) {
    final validStatuses = [
      'todo',
      'in_progress',
      'review',
      'done',
    ];

    /// Agar API/mock data me koi different
    /// status aa jaye to dropdown crash nahi karega.
    final dropdownValue =
        validStatuses.contains(selectedStatus)
            ? selectedStatus
            : 'todo';

    return DropdownButton<String>(
      value: dropdownValue,

      isExpanded: true,

      underline:
          const SizedBox(),

      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        color: Color(0xFF6C4ED9),
      ),

      items: const [
        DropdownMenuItem(
          value: 'todo',
          child: Text('To Do'),
        ),

        DropdownMenuItem(
          value: 'in_progress',
          child: Text('In Progress'),
        ),

        DropdownMenuItem(
          value: 'review',
          child: Text('Review'),
        ),

        DropdownMenuItem(
          value: 'done',
          child: Text('Done'),
        ),
      ],

      onChanged: (value) {
        if (value != null) {
          setState(() {
            selectedStatus = value;
          });

          /// Tumhara current logic same rakha hai.
          /// Agar status change karte hi API/mock data
          /// update karna hai to yahan ye method use kar sakte ho:
          ///
          /// taskController.updateTaskStatus(
          ///   task: task,
          ///   status: value,
          /// );
        }
      },
    );
  }

  Color _getPriorityColor(
    String priority,
  ) {
    switch (priority.toLowerCase()) {
      case 'high':
        return const Color(0xFFE05252);

      case 'medium':
        return const Color(0xFFF59E0B);

      case 'low':
        return const Color(0xFF22A06B);

      default:
        return const Color(0xFF6C4ED9);
    }
  }

  String _formatText(
    String value,
  ) {
    return value
        .split('_')
        .map(
          (word) =>
              word.isEmpty
                  ? ''
                  : '${word[0].toUpperCase()}${word.substring(1)}',
        )
        .join(' ');
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