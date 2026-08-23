// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:task_manager/controller/auth_controller.dart';
// import 'package:task_manager/controller/project_controller.dart';
// import 'package:task_manager/controller/task_controller.dart';

// class ProjectDetailScreen
//     extends StatefulWidget {
//   const ProjectDetailScreen({
//     super.key,
//   });

//   @override
//   State<ProjectDetailScreen> createState() {
//     return _ProjectDetailScreenState();
//   }
// }

// class _ProjectDetailScreenState
//     extends State<ProjectDetailScreen> {
//   final projectController =
//       Get.find<ProjectController>();
//         final taskController =
//       Get.find<TaskController>();

//   final authController =
//       Get.find<AuthController>();

//   late final String projectId;

//   @override
//   void initState() {
//     super.initState();

//     projectId = Get.arguments as String;

//     Future.microtask(() {
//       projectController
//           .loadProjectDetails(
//         projectId,
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title:
//             const Text('Project Details'),

//         actions: [
//           Obx(() {
//             if (!authController.isAdmin) {
//               return const SizedBox();
//             }

//             return IconButton(
//               icon:
//                   const Icon(Icons.delete),

//               onPressed: () {
//                 _showDeleteDialog();
//               },
//             );
//           }),
//         ],
//       ),

//       body: Obx(() {
//         final project =
//             projectController
//                 .selectedProject.value;

//         if (project == null) {
//           return const Center(
//             child:
//                 CircularProgressIndicator(),
//           );
//         }

//         return Padding(
//           padding:
//               const EdgeInsets.all(20),

//           child: Column(
//             crossAxisAlignment:
//                 CrossAxisAlignment.start,

//             children: [
//               Text(
//                 project.name,
//                 style: const TextStyle(
//                   fontSize: 26,
//                   fontWeight:
//                       FontWeight.bold,
//                 ),
//               ),

//               const SizedBox(height: 16),

//               Text(
//                 project.description ??
//                     'No description',
//               ),

//               const SizedBox(height: 24),

//               Row(
//                 children: [
//                   const Text(
//                     'Status: ',
//                     style: TextStyle(
//                       fontWeight:
//                           FontWeight.bold,
//                     ),
//                   ),

//                   Text(
//                     project.status,
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 30),

//               const Text(
//                 'Tasks',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight:
//                       FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 16),

// SizedBox(
//   width: double.infinity,
//   child: ElevatedButton.icon(
//     onPressed: () {
//       Get.toNamed(
//         '/tasks',
//         arguments: project.id,
//       );
//     },
//     icon: const Icon(Icons.task),
//     label: const Text('View Tasks'),
//   ),
// ),

//               const SizedBox(height: 10),

//               const Expanded(
//                 child: Center(
//                   child: Text(
//                     'Task list will be added in Part 5',
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       }),
//     );
//   }

//   void _showDeleteDialog() {
//     Get.defaultDialog(
//       title: 'Delete Project',

//       middleText:
//           'Are you sure you want to delete this project?',

//       textCancel: 'Cancel',

//       textConfirm: 'Delete',

//       confirmTextColor: Colors.white,

//       onConfirm: () {
//         projectController.deleteProject(
//           projectId: projectId,

//           userId:
//               authController.currentUserId,

//           organizationId: authController
//               .currentOrganizationId,
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller/auth_controller.dart';
import 'package:task_manager/controller/project_controller.dart';
import 'package:task_manager/controller/task_controller.dart';

class ProjectDetailScreen extends StatefulWidget {
  const ProjectDetailScreen({
    super.key,
  });

  @override
  State<ProjectDetailScreen> createState() {
    return _ProjectDetailScreenState();
  }
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  final projectController = Get.find<ProjectController>();

  final taskController = Get.find<TaskController>();

  final authController = Get.find<AuthController>();

  late final String projectId;

  @override
  void initState() {
    super.initState();

    projectId = Get.arguments as String;

    Future.microtask(() {
      projectController.loadProjectDetails(
        projectId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFF0B0D1C);
    const cardColor = Color(0xFF15182B);
    const purpleColor = Color(0xFF8B5CF6);
    const lightPurple = Color(0xFFB794F6);
    const textColor = Color(0xFFF4F4F8);
    const subTextColor = Color(0xFFA7A9B8);

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

        title: const Text(
          'Project Details',
          style: TextStyle(
            color: textColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),

        actions: [
          Obx(() {
            if (!authController.isAdmin) {
              return const SizedBox();
            }

            return Padding(
              padding: const EdgeInsets.only(right: 8),

              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),

                child: IconButton(
                  icon: const Icon(
                    Icons.delete_outline_rounded,
                    color: Color(0xFFFF6B6B),
                  ),

                  onPressed: () {
                    _showDeleteDialog();
                  },
                ),
              ),
            );
          }),
        ],
      ),

      body: Obx(() {
        final project = projectController.selectedProject.value;

        if (project == null) {
          return const Center(
            child: CircularProgressIndicator(
              color: purpleColor,
            ),
          );
        }

        return Stack(
          children: [
            /// Background decoration
            Positioned(
              top: -120,
              right: -100,
              child: Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: purpleColor.withOpacity(0.08),
                ),
              ),
            ),

            Positioned(
              bottom: 30,
              left: -50,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: lightPurple.withOpacity(0.04),
                ),
              ),
            ),

            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                20,
                24,
                20,
                30,
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  /// Project Icon + Status
                  Row(
                    children: [
                      Container(
                        width: 58,
                        height: 58,

                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF8B5CF6),
                              Color(0xFF5B4FCF),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),

                          borderRadius: BorderRadius.circular(18),

                          boxShadow: [
                            BoxShadow(
                              color: purpleColor.withOpacity(0.25),
                              blurRadius: 18,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),

                        child: const Icon(
                          Icons.folder_open_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),

                      const Spacer(),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),

                        decoration: BoxDecoration(
                          color: purpleColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: purpleColor.withOpacity(0.25),
                          ),
                        ),

                        child: Text(
                          project.status.toUpperCase(),
                          style: const TextStyle(
                            color: lightPurple,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  /// Project Name
                  Text(
                    project.name,
                    style: const TextStyle(
                      color: textColor,
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
                  ),

                  const SizedBox(height: 14),

                  /// Description
                  Text(
                    project.description ?? 'No description available',
                    style: const TextStyle(
                      color: subTextColor,
                      fontSize: 15,
                      height: 1.7,
                    ),
                  ),

                  const SizedBox(height: 32),

                  /// Project Information Card
                  Container(
                    width: double.infinity,

                    padding: const EdgeInsets.all(20),

                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(22),

                      border: Border.all(
                        color: Colors.white.withOpacity(0.06),
                      ),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.18),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        const Text(
                          'PROJECT OVERVIEW',
                          style: TextStyle(
                            color: lightPurple,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                          ),
                        ),

                        const SizedBox(height: 18),

                        Row(
                          children: [
                            Container(
                              width: 42,
                              height: 42,

                              decoration: BoxDecoration(
                                color: purpleColor.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(12),
                              ),

                              child: const Icon(
                                Icons.info_outline_rounded,
                                color: lightPurple,
                                size: 22,
                              ),
                            ),

                            const SizedBox(width: 14),

                            const Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,

                                children: [
                                  Text(
                                    'Current Status',
                                    style: TextStyle(
                                      color: subTextColor,
                                      fontSize: 12,
                                    ),
                                  ),

                                  SizedBox(height: 4),

                                  Text(
                                    'Project is currently active',
                                    style: TextStyle(
                                      color: textColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  /// Tasks Heading
                  const Text(
                    'Tasks',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 23,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Manage and track all tasks for this project.',
                    style: TextStyle(
                      color: subTextColor,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 18),

                  /// View Tasks Card/Button
                  InkWell(
                    borderRadius: BorderRadius.circular(20),

                    onTap: () {
                      Get.toNamed(
                        '/tasks',
                        arguments: project.id,
                      );
                    },

                    child: Ink(
                      width: double.infinity,

                      padding: const EdgeInsets.all(20),

                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF8B5CF6),
                            Color(0xFF5B4FCF),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),

                        borderRadius: BorderRadius.circular(20),

                        boxShadow: [
                          BoxShadow(
                            color: purpleColor.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),

                      child: const Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.white24,

                            child: Icon(
                              Icons.task_alt_rounded,
                              color: Colors.white,
                              size: 26,
                            ),
                          ),

                          SizedBox(width: 16),

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,

                              children: [
                                Text(
                                  'View Tasks',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),

                                SizedBox(height: 4),

                                Text(
                                  'Open all tasks in this project',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  /// Bottom information
                  Center(
                    child: Text(
                      'Select View Tasks to manage project tasks',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: subTextColor.withOpacity(0.7),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  void _showDeleteDialog() {
    Get.defaultDialog(
      title: 'Delete Project',

      middleText:
          'Are you sure you want to delete this project?',

      textCancel: 'Cancel',

      textConfirm: 'Delete',

      confirmTextColor: Colors.white,

      onConfirm: () {
        projectController.deleteProject(
          projectId: projectId,

          userId: authController.currentUserId,

          organizationId:
              authController.currentOrganizationId,
        );
      },
    );
  }
}