
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:task_manager/app/routes/app_routes.dart';
import 'package:task_manager/controller/auth_controller.dart';
import 'package:task_manager/controller/project_controller.dart';
import 'package:task_manager/controller/task_controller.dart';
// import 'package:task_manager/controller/task_controller.dart';
import 'package:task_manager/data/datasources/mock/mock_data_source.dart';
import 'package:task_manager/repositories/project_repository.dart';
import 'package:task_manager/repositories/project_repository_impl.dart';
import 'package:task_manager/repositories/task_repository.dart';
import 'package:task_manager/repositories/task_repository_impl.dart';
import 'package:task_manager/screens/projects/project_list_screen.dart';
import 'package:task_manager/screens/task/task_list_screen.dart';


// import '../../controllers/auth_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController =
        Get.find<AuthController>();
   

    return Scaffold(
      appBar: AppBar(
        title: const Text('TaskFlow'),

        actions: [
          IconButton(
            onPressed: () {
              authController.logout();
            },
            icon:
                const Icon(Icons.logout),
          ),
        ],
      ),

      body: Obx(() {
        final session =
            authController.currentSession.value;

        if (session == null) {
          return const Center(
            child: Text(
              'No active session',
            ),
          );
        }

        return Padding(
          padding:
              const EdgeInsets.all(24),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              Text(
                'Welcome to TaskFlow',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium,
              ),

              const SizedBox(height: 30),

              Text(
                'User ID: ${session.userId}',
              ),

              const SizedBox(height: 12),

              Text(
                'Organization ID: '
                '${session.organizationId}',
              ),

              const SizedBox(height: 12),

              Text(
                'Role: ${session.role}',
              ),

              const SizedBox(height: 12),

              Text(
                'Token expires at:\n'
                '${session.expiresAt}',
              ),

              const SizedBox(height: 30),
              ElevatedButton.icon(
  onPressed: () {
      Get.toNamed('/projects');

  
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => const ProjectListScreen(),
    ));
  },
  icon: const Icon(Icons.folder),
  label: const Text('View Projects'),
),
const SizedBox(height: 30),

              const SizedBox(height: 30),

              ElevatedButton.icon(
  onPressed: () {
    Get.toNamed(
      '/tasks',
      arguments: 'proj_1001',
    );
  },
  icon: const Icon(Icons.folder),
  label: const Text('Task'),
),
//               ElevatedButton.icon(
//   onPressed: () {
//      Get.toNamed(
//       '/tasks',
//       arguments: 'project_1',
//     );
   

    
//   },
//   icon: const Icon(Icons.folder),
//   label: const Text('task'),
// ),


              ElevatedButton.icon(
                onPressed: () {
                  authController.logout();
                },

                icon:
                    const Icon(Icons.logout),

                label:
                    const Text('Logout'),
              ),
            ],
          ),
        );
      }),
    );
  }
}