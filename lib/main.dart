
// // // import 'package:flutter/material.dart';
// // // import 'package:get/get.dart';

// // // import 'app/bindings/initial_binding.dart';
// // // import 'app/routes/app_pages.dart';
// // // import 'app/routes/app_routes.dart';

// // // void main() {
// // //   runApp(const MyApp());
// // // }

// // // class MyApp extends StatelessWidget {
// // //   const MyApp({super.key});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return GetMaterialApp(
// // //       debugShowCheckedModeBanner: false,

// // //       // IMPORTANT
// // //       initialBinding: InitialBinding(),

// // //       initialRoute: AppRoutes.splash,

// // //       getPages: AppPages.pages,
// // //     );
// // //   }
// // // }
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';

// // import 'app/routes/app_routes.dart';
// // import 'app/routes/app_pages.dart';
// // import 'app/bindings/initial_binding.dart';

// // void main() {
// //   WidgetsFlutterBinding.ensureInitialized();

// //   debugPrint('========== MAIN STARTED ==========');

// //   runApp(
// //     const MyApp(),
// //   );
// // }

// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     debugPrint('========== MYAPP BUILD ==========');

// //     return GetMaterialApp(
// //       debugShowCheckedModeBanner: false,

// //       initialBinding: InitialBinding(),

// //       initialRoute: AppRoutes.splash,

// //       getPages: AppPages.pages,

// //       builder: (context, child) {
// //         debugPrint('========== APP BUILDER RUNNING ==========');
// //         return child!;
// //       },
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';

// void main() {
//   runApp(
//     const MaterialApp(
//       home: TestScreen(),
//     ),
//   );
// }

// class TestScreen extends StatelessWidget {
//   const TestScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Text(
//           'MAIN FILE IS WORKING',
//           style: TextStyle(
//             fontSize: 28,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller/project_controller.dart';
import 'package:task_manager/controller/task_controller.dart';
import 'package:task_manager/repositories/project_repository.dart';
import 'package:task_manager/repositories/project_repository_impl.dart';
import 'package:task_manager/repositories/task_repository.dart';
import 'package:task_manager/screens/projects/task_repo.dart';

import 'controller/auth_controller.dart';
import 'core/services/secure_storage_service.dart';
import 'data/datasources/mock/mock_data_source.dart';
import 'repositories/auth_repository.dart';
import 'repositories/auth_repository_impl.dart';

import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // ==========================================
  // REGISTER ONLY LOGIN DEPENDENCIES
  // ==========================================

  Get.put<MockDataSource>(
    MockDataSource(),
    permanent: true,
  );

  Get.put<SecureStorageService>(
    SecureStorageService(),
    permanent: true,
  );

  

  Get.put<AuthRepository>(
    AuthRepositoryImpl(
      mockDataSource: Get.find<MockDataSource>(),
      secureStorage: Get.find<SecureStorageService>(),
    ),
    permanent: true,
  );

  // PROJECT REPOSITORY
  // ==========================================

  Get.put<ProjectRepository>(
    ProjectRepositoryImpl(
      mockDataSource: Get.find<MockDataSource>(),
    ),
    permanent: true,
  );

  // ==========================================
  // TASK REPOSITORY
  // ==========================================

  Get.put<TaskRepository>(
    TaskRepositoryImplfunction(
      mockDataSource: Get.find<MockDataSource>(),
    ),
    permanent: true,
  );


  Get.put<AuthController>(
    AuthController(
      repository: Get.find<AuthRepository>(),
    ),
    permanent: true,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      // App direct login page se start hoga
      home: const LoginScreen(),

      // Login ke baad navigation ke liye routes
      getPages: [
        GetPage(
          name: '/login',
          page: () => const LoginScreen(),
        ),

        GetPage(
          name: '/home',
          page: () => HomeScreen(),
        ),
      ],
    );
  }
}