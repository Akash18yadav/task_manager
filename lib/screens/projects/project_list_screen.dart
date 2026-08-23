// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:task_manager/app/widget/project_card.dart';
// import 'package:task_manager/controller/auth_controller.dart';
// import 'package:task_manager/controller/project_controller.dart';
// import 'package:task_manager/controller/task_controller.dart';

// import '../../../core/enums/view_state.dart';


// class ProjectListScreen
//     extends StatefulWidget {
//   const ProjectListScreen({super.key});

//   @override
//   State<ProjectListScreen> createState() {
//     return _ProjectListScreenState();
//   }
// }

// class _ProjectListScreenState
//     extends State<ProjectListScreen> {
//   final projectController =
//       Get.find<ProjectController>();

//   final authController =
//       Get.find<AuthController>();
//       final taskController =
//     Get.find<TaskController>();

//   // @override
//   // void initState() {
//   //   super.initState();

//   //   Future.microtask(() {
//   //     projectController.loadProjects(
//   //       authController.currentOrganizationId,
//   //     );
//   //   });
//   // }
//   @override
// void initState() {
//   super.initState();

//   Future.microtask(() async {
//     await projectController.loadProjects(
//       authController.currentOrganizationId,
//     );

//     final projectIds =
//         projectController.projects
//             .map(
//               (project) => project.id,
//             )
//             .toList();

//     await taskController
//         .loadAllTasksForProjects(
//       projectIds,
//     );
//   });
// }

//   int getTaskCount(String projectId) {
//     // Part 5 mein TaskController use hoga.
//     // Abhi temporary value.
//     return 0;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Projects'),
//       ),

//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Create Project
//         },

//         child: const Icon(Icons.add),
//       ),

//       body: Obx(() {
//         switch (
//             projectController.state.value) {
//           case ViewState.initial:
//           case ViewState.loading:
//             return const Center(
//               child:
//                   CircularProgressIndicator(),
//             );

//           case ViewState.empty:
//             return _buildEmptyState();

//           case ViewState.error:
//             return _buildErrorState();

//           case ViewState.success:
//             return RefreshIndicator(
//               onRefresh: () =>
//                   projectController
//                       .refreshProjects(
//                 authController
//                     .currentOrganizationId,
//               ),

//               child: ListView.builder(
//                 physics:
//                     const AlwaysScrollableScrollPhysics(),

//                 itemCount:
//                     projectController
//                         .projects
//                         .length,

//                 itemBuilder:
//                     (context, index) {
//                   final project =
//                       projectController
//                           .projects[index];

//                   return ProjectCard(
//                     project: project,
//                     taskCount:
//                         getTaskCount(project.id),

//                     onTap: () {
//                       Get.toNamed(
//                         '/project-detail',
//                         arguments: project.id,
//                       );
//                     },
//                   );
//                 },
//               ),
//             );
//         }
//       }),
//     );
//   }

//   Widget _buildEmptyState() {
//     return const Center(
//       child: Column(
//         mainAxisAlignment:
//             MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.folder_open,
//             size: 70,
//           ),

//           SizedBox(height: 16),

//           Text(
//             'No Projects Found',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight:
//                   FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildErrorState() {
//     return Center(
//       child: Padding(
//         padding:
//             const EdgeInsets.all(24),

//         child: Column(
//           mainAxisAlignment:
//               MainAxisAlignment.center,

//           children: [
//             const Icon(
//               Icons.error_outline,
//               size: 70,
//               color: Colors.red,
//             ),

//             const SizedBox(height: 16),

//             Text(
//               projectController
//                   .errorMessage.value,
//               textAlign:
//                   TextAlign.center,
//             ),

//             const SizedBox(height: 20),

//             ElevatedButton(
//               onPressed: () {
//                 projectController
//                     .loadProjects(
//                   authController
//                       .currentOrganizationId,
//                 );
//               },

//               child: const Text(
//                 'Retry',
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:task_manager/app/widget/project_card.dart';
import 'package:task_manager/controller/auth_controller.dart';
import 'package:task_manager/controller/project_controller.dart';
import 'package:task_manager/controller/task_controller.dart';

import '../../../core/enums/view_state.dart';

class ProjectListScreen extends StatefulWidget {
  const ProjectListScreen({super.key});

  @override
  State<ProjectListScreen> createState() {
    return _ProjectListScreenState();
  }
}

class _ProjectListScreenState
    extends State<ProjectListScreen> {

  final projectController =
      Get.find<ProjectController>();

  final authController =
      Get.find<AuthController>();

  final taskController =
      Get.find<TaskController>();

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      await projectController.loadProjects(
        authController.currentOrganizationId,
      );

      final projectIds =
          projectController.projects
              .map(
                (project) => project.id,
              )
              .toList();

      await taskController
          .loadAllTasksForProjects(
        projectIds,
      );
    });
  }

  int getTaskCount(String projectId) {
    return taskController.tasks
        .where(
          (task) =>
              task.projectId == projectId,
        )
        .length;
  }

  Future<void> _refreshData() async {
    await projectController.refreshProjects(
      authController.currentOrganizationId,
    );

    final projectIds =
        projectController.projects
            .map(
              (project) => project.id,
            )
            .toList();

    await taskController
        .loadAllTasksForProjects(
      projectIds,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Projects',
        ),
      ),

      floatingActionButton:
          FloatingActionButton(
        onPressed: () {
          // Next step:
          // Create Project Screen
        },
        child: const Icon(Icons.add),
      ),

      body: Obx(() {
        switch (
            projectController.state.value) {

          case ViewState.initial:
          case ViewState.loading:

            return const Center(
              child:
                  CircularProgressIndicator(),
            );

          case ViewState.empty:

            return _buildEmptyState();

          case ViewState.error:

            return _buildErrorState();

          case ViewState.success:

            return RefreshIndicator(
              onRefresh: _refreshData,

              child: Obx(() {
                return ListView.builder(
                  physics:
                      const AlwaysScrollableScrollPhysics(),

                  itemCount:
                      projectController
                          .projects
                          .length,

                  itemBuilder:
                      (context, index) {

                    final project =
                        projectController
                            .projects[index];

                    return ProjectCard(
                      project: project,

                      taskCount:
                          getTaskCount(
                        project.id,
                      ),

                      onTap: () {
                        Get.toNamed(
                          '/project-detail',
                          arguments:
                              project.id,
                        );
                      },
                    );
                  },
                );
              }),
            );
        }
      }),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [

          Icon(
            Icons.folder_open,
            size: 70,
          ),

          SizedBox(height: 16),

          Text(
            'No Projects Found',
            style: TextStyle(
              fontSize: 18,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.all(24),

        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            const Icon(
              Icons.error_outline,
              size: 70,
              color: Colors.red,
            ),

            const SizedBox(height: 16),

            Text(
              projectController
                  .errorMessage.value,
              textAlign:
                  TextAlign.center,
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                _refreshData();
              },

              child: const Text(
                'Retry',
              ),
            ),
          ],
        ),
      ),
    );
  }
}