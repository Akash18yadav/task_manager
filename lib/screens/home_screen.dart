// import 'package:flutter/material.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('TaskFlow'),
//       ),
//       body: const Center(
//         child: Text('Home Screen'),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller/auth_controller.dart';

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
  },
  icon: const Icon(Icons.folder),
  label: const Text('View Projects'),
),
const SizedBox(height: 30),

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