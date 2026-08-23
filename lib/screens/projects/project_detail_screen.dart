import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller/auth_controller.dart';
import 'package:task_manager/controller/project_controller.dart';
import 'package:task_manager/controller/task_controller.dart';

class ProjectDetailScreen
    extends StatefulWidget {
  const ProjectDetailScreen({
    super.key,
  });

  @override
  State<ProjectDetailScreen> createState() {
    return _ProjectDetailScreenState();
  }
}

class _ProjectDetailScreenState
    extends State<ProjectDetailScreen> {
  final projectController =
      Get.find<ProjectController>();
        final taskController =
      Get.find<TaskController>();

  final authController =
      Get.find<AuthController>();

  late final String projectId;

  @override
  void initState() {
    super.initState();

    projectId = Get.arguments as String;

    Future.microtask(() {
      projectController
          .loadProjectDetails(
        projectId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Project Details'),

        actions: [
          Obx(() {
            if (!authController.isAdmin) {
              return const SizedBox();
            }

            return IconButton(
              icon:
                  const Icon(Icons.delete),

              onPressed: () {
                _showDeleteDialog();
              },
            );
          }),
        ],
      ),

      body: Obx(() {
        final project =
            projectController
                .selectedProject.value;

        if (project == null) {
          return const Center(
            child:
                CircularProgressIndicator(),
          );
        }

        return Padding(
          padding:
              const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              Text(
                project.name,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              Text(
                project.description ??
                    'No description',
              ),

              const SizedBox(height: 24),

              Row(
                children: [
                  const Text(
                    'Status: ',
                    style: TextStyle(
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  Text(
                    project.status,
                  ),
                ],
              ),

              const SizedBox(height: 30),

              const Text(
                'Tasks',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

SizedBox(
  width: double.infinity,
  child: ElevatedButton.icon(
    onPressed: () {
      Get.toNamed(
        '/tasks',
        arguments: project.id,
      );
    },
    icon: const Icon(Icons.task),
    label: const Text('View Tasks'),
  ),
),

              const SizedBox(height: 10),

              const Expanded(
                child: Center(
                  child: Text(
                    'Task list will be added in Part 5',
                  ),
                ),
              ),
            ],
          ),
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

          userId:
              authController.currentUserId,

          organizationId: authController
              .currentOrganizationId,
        );
      },
    );
  }
}