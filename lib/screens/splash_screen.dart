// // import 'package:flutter/material.dart';

// // class SplashScreen extends StatelessWidget {
// //   const SplashScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return const Scaffold(
// //       body: Center(
// //         child: Text(
// //           'TaskFlow',
// //           style: TextStyle(
// //             fontSize: 32,
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../data/datasources/mock/mock_data_source.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() {
//     return _SplashScreenState();
//   }
// }

// class _SplashScreenState
//     extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();

//     loadMockData();
//   }

//   Future<void> loadMockData() async {
//     final mockDataSource =
//         Get.find<MockDataSource>();

//     final projects =
//         await mockDataSource.getProjects();

//     debugPrint(
//       'Tttttttttttotal Projects: ${projects.length}',
//     );

//     final tasks =
//         await mockDataSource.getTasks();

//     debugPrint(
//       'Total Tasks: ${tasks.length}',
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Text(
//           'Loading TaskFlow...',
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller/auth_controller.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState
    extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );

    final authController =
        Get.find<AuthController>();

    await authController.checkSession();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(
              Icons.task_alt_rounded,
              size: 80,
            ),

            SizedBox(height: 16),

            Text(
              'TaskFlow',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            Text(
              'Manage your work efficiently',
            ),

            SizedBox(height: 30),

            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}