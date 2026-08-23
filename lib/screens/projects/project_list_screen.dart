
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'package:task_manager/app/widget/project_card.dart';
// import 'package:task_manager/controller/auth_controller.dart';
// import 'package:task_manager/controller/project_controller.dart';
// import 'package:task_manager/controller/task_controller.dart';

// import '../../../core/enums/view_state.dart';

// class ProjectListScreen extends StatefulWidget {
//   const ProjectListScreen({
//     super.key,
//   });

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

//   final taskController =
//       Get.find<TaskController>();

//   @override
//   void initState() {
//     super.initState();

//     print('');
//     print(
//       '========== PROJECT LIST SCREEN INIT ==========',
//     );

//     print(
//       'Current Organization ID: '
//       '${authController.currentOrganizationId}',
//     );

//     print(
//       'Current User ID: '
//       '${authController.currentSession.value?.userId}',
//     );

//     print(
//       'ProjectController registered: '
//       '${Get.isRegistered<ProjectController>()}',
//     );

//     print(
//       'TaskController registered: '
//       '${Get.isRegistered<TaskController>()}',
//     );

//     Future.microtask(() async {
//       print(
//         'Starting project loading...',
//       );

//       await projectController.loadProjects(
//         authController.currentOrganizationId,
//       );

//       print(
//         'After loadProjects count: '
//         '${projectController.projects.length}',
//       );

//       final projectIds =
//           projectController.projects
//               .map(
//                 (project) => project.id,
//               )
//               .toList();

//       print(
//         'Project IDs found: $projectIds',
//       );

//       if (projectIds.isNotEmpty) {
//         print(
//           'Loading tasks for projects...',
//         );

//         await taskController
//             .loadAllTasksForProjects(
//           projectIds,
//         );
//       } else {
//         print(
//           'NO PROJECTS FOUND, TASK LOAD SKIPPED',
//         );
//       }
//     });
//   }

//   int getTaskCount(String projectId) {
//     final count = taskController.tasks
//         .where(
//           (task) =>
//               task.projectId == projectId,
//         )
//         .length;

//     print(
//       'Task count for $projectId: $count',
//     );

//     return count;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Projects'),
//       ),

//       floatingActionButton:
//           FloatingActionButton(
//         onPressed: () {
//           print(
//             'ADD PROJECT BUTTON CLICKED',
//           );
//         },
//         child: const Icon(Icons.add),
//       ),

//       body: Obx(() {
//         print(
//           'BUILD ProjectListScreen',
//         );

//         print(
//           'Current State: '
//           '${projectController.state.value}',
//         );

//         print(
//           'Current Projects Count: '
//           '${projectController.projects.length}',
//         );

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

//                   print(
//                     'Showing Project on UI: '
//                     '${project.name}',
//                   );

//                   return ProjectCard(
//                     project: project,

//                     taskCount:
//                         getTaskCount(
//                       project.id,
//                     ),

//                     onTap: () {
//                       print(
//                         'Project clicked: '
//                         '${project.id}',
//                       );

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
//     print(
//       'UI SHOWING: NO PROJECTS FOUND',
//     );

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
//                 print(
//                   'RETRY PROJECT LOADING',
//                 );

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
  const ProjectListScreen({
    super.key,
  });

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

    print('');
    print(
      '========== PROJECT LIST SCREEN INIT ==========',
    );

    print(
      'Current Organization ID: '
      '${authController.currentOrganizationId}',
    );

    print(
      'Current User ID: '
      '${authController.currentSession.value?.userId}',
    );

    print(
      'ProjectController registered: '
      '${Get.isRegistered<ProjectController>()}',
    );

    print(
      'TaskController registered: '
      '${Get.isRegistered<TaskController>()}',
    );

    Future.microtask(() async {
      print(
        'Starting project loading...',
      );

      await projectController.loadProjects(
        authController.currentOrganizationId,
      );

      print(
        'After loadProjects count: '
        '${projectController.projects.length}',
      );

      final projectIds =
          projectController.projects
              .map(
                (project) => project.id,
              )
              .toList();

      print(
        'Project IDs found: $projectIds',
      );

      if (projectIds.isNotEmpty) {
        print(
          'Loading tasks for projects...',
        );

        await taskController
            .loadAllTasksForProjects(
          projectIds,
        );
      } else {
        print(
          'NO PROJECTS FOUND, TASK LOAD SKIPPED',
        );
      }
    });
  }

  int getTaskCount(String projectId) {
    final count = taskController.tasks
        .where(
          (task) =>
              task.projectId == projectId,
        )
        .length;

    print(
      'Task count for $projectId: $count',
    );

    return count;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFF0B0C1C),

      appBar: AppBar(
        backgroundColor:
            const Color(0xFF0B0C1C),

        elevation: 0,

        scrolledUnderElevation: 0,

        surfaceTintColor:
            Colors.transparent,

        centerTitle: false,

        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 22,
          ),
        ),

        title: const Text(
          'Projects',
          style: TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {
              // Future search functionality
            },
            icon: const Icon(
              Icons.search_rounded,
              color: Colors.white,
              size: 26,
            ),
          ),

          const SizedBox(width: 8),
        ],
      ),

      floatingActionButton:
          Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF9B6BFF),
              Color(0xFF5D2DAA),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(
                0xFF8A5CFF,
              ).withOpacity(0.35),
              blurRadius: 18,
              spreadRadius: 2,
              offset: const Offset(0, 6),
            ),
          ],
        ),

        child: FloatingActionButton(
          heroTag: 'add_project',
          elevation: 0,
          backgroundColor:
              Colors.transparent,
          onPressed: () {
            print(
              'ADD PROJECT BUTTON CLICKED',
            );
          },
          child: const Icon(
            Icons.add_rounded,
            color: Colors.white,
            size: 32,
          ),
        ),
      ),

      body: Stack(
        children: [

          /// Main Content
          Obx(() {
            print(
              'BUILD ProjectListScreen',
            );

            print(
              'Current State: '
              '${projectController.state.value}',
            );

            print(
              'Current Projects Count: '
              '${projectController.projects.length}',
            );

            switch (
                projectController.state.value) {
              case ViewState.initial:
              case ViewState.loading:
                return const Center(
                  child:
                      CircularProgressIndicator(
                    color: Color(
                      0xFF9B6BFF,
                    ),
                  ),
                );

              case ViewState.empty:
                return _buildEmptyState();

              case ViewState.error:
                return _buildErrorState();

              case ViewState.success:
                return RefreshIndicator(
                  color: const Color(
                    0xFF9B6BFF,
                  ),
                  backgroundColor:
                      const Color(
                    0xFF17182B,
                  ),

                  onRefresh: () =>
                      projectController
                          .refreshProjects(
                    authController
                        .currentOrganizationId,
                  ),

                  child: ListView.builder(
                    padding:
                        const EdgeInsets.fromLTRB(
                      16,
                      12,
                      16,
                      110,
                    ),

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

                      print(
                        'Showing Project on UI: '
                        '${project.name}',
                      );

                      return _buildProjectCard(
                        projectName:
                            project.name,

                        description:
                            project.description ??
                                'No description available',

                        status:
                            project.status,

                        taskCount:
                            getTaskCount(
                          project.id,
                        ),

                        index: index,

                        onTap: () {
                          print(
                            'Project clicked: '
                            '${project.id}',
                          );

                          Get.toNamed(
                            '/project-detail',
                            arguments:
                                project.id,
                          );
                        },
                      );
                    },
                  ),
                );
            }
          }),

          /// Bottom decorative dots
          Positioned(
            left: 18,
            bottom: 22,
            child: _buildDots(),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard({
    required String projectName,
    required String description,
    required String status,
    required int taskCount,
    required int index,
    required VoidCallback onTap,
  }) {
    final bool isWebsite =
        index % 2 == 0;

    final icon = isWebsite
        ? Icons.language_rounded
        : Icons.phone_android_rounded;

    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 22,
      ),

      child: InkWell(
        onTap: onTap,

        borderRadius:
            BorderRadius.circular(18),

        child: Container(
          width: double.infinity,

          padding:
              const EdgeInsets.all(16),

          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(18),

            gradient:
                const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF17182D),
                Color(0xFF10111F),
              ],
            ),

            border: Border.all(
              color: const Color(
                0xFF30304D,
              ),
              width: 1,
            ),

            boxShadow: [
              BoxShadow(
                color: Colors.black
                    .withOpacity(0.18),
                blurRadius: 12,
                offset:
                    const Offset(0, 5),
              ),
            ],
          ),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              /// Icon + Status
              Row(
                mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,

                children: [
                  Container(
                    height: 50,
                    width: 50,

                    decoration:
                        BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(
                        12,
                      ),

                      gradient:
                          const LinearGradient(
                        begin:
                            Alignment.topLeft,
                        end:
                            Alignment.bottomRight,
                        colors: [
                          Color(
                            0xFF8F63E8,
                          ),
                          Color(
                            0xFF4E318C,
                          ),
                        ],
                      ),
                    ),

                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),

                  Container(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 11,
                      vertical: 7,
                    ),

                    decoration:
                        BoxDecoration(
                      color:
                          const Color(
                        0xFF34265A,
                      ),

                      borderRadius:
                          BorderRadius.circular(
                        8,
                      ),
                    ),

                    child: Text(
                      status
                          .replaceAll(
                            '_',
                            ' ',
                          )
                          .toUpperCase(),

                      style:
                          const TextStyle(
                        color:
                            Color(0xFFC7A8FF),
                        fontSize: 11,
                        fontWeight:
                            FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 16,
              ),

              /// Project Name
              Text(
                projectName,

                maxLines: 1,

                overflow:
                    TextOverflow.ellipsis,

                style:
                    const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight:
                      FontWeight.w600,
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              /// Description
              Text(
                description,

                maxLines: 3,

                overflow:
                    TextOverflow.ellipsis,

                style:
                    TextStyle(
                  color: Colors.white
                      .withOpacity(0.65),
                  fontSize: 14,
                  height: 1.55,
                ),
              ),

              const SizedBox(
                height: 18,
              ),

              Container(
                height: 1,
                color: const Color(
                  0xFF292A42,
                ),
              ),

              const SizedBox(
                height: 14,
              ),

              /// Task Count + Arrow
              Row(
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    color:
                        Color(0xFFB57CFF),
                    size: 21,
                  ),

                  const SizedBox(
                    width: 10,
                  ),

                  Text(
                    '$taskCount Tasks',

                    style:
                        const TextStyle(
                      color:
                          Color(0xFFC4A4FF),
                      fontSize: 15,
                      fontWeight:
                          FontWeight.w500,
                    ),
                  ),

                  const Spacer(),

                  const Icon(
                    Icons
                        .arrow_forward_ios_rounded,
                    color:
                        Color(0xFFB57CFF),
                    size: 18,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDots() {
    return SizedBox(
      width: 70,
      height: 50,

      child: Wrap(
        spacing: 8,
        runSpacing: 8,

        children: List.generate(
          24,
          (index) => Container(
            height: 3,
            width: 3,

            decoration:
                const BoxDecoration(
              color:
                  Color(0xFF4C2D91),
              shape:
                  BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    print(
      'UI SHOWING: NO PROJECTS FOUND',
    );

    return const Center(
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          Icon(
            Icons.folder_open_rounded,
            size: 75,
            color: Color(0xFF9B6BFF),
          ),

          SizedBox(height: 16),

          Text(
            'No Projects Found',
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
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
              color: Colors.redAccent,
            ),

            const SizedBox(
              height: 16,
            ),

            Text(
              projectController
                  .errorMessage.value,

              textAlign:
                  TextAlign.center,

              style:
                  const TextStyle(
                color: Colors.white70,
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(
                  0xFF7953D8,
                ),

                foregroundColor:
                    Colors.white,

                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 14,
                ),
              ),

              onPressed: () {
                print(
                  'RETRY PROJECT LOADING',
                );

                projectController
                    .loadProjects(
                  authController
                      .currentOrganizationId,
                );
              },

              child:
                  const Text(
                'Retry',
              ),
            ),
          ],
        ),
      ),
    );
  }
}