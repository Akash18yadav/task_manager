// // // import 'package:get/get.dart';
// // // import 'package:task_manager/controller/auth_controller.dart';
// // // import 'package:task_manager/controller/task_controller.dart';
// // // import 'package:task_manager/domain/repositories/auth_repository_impl.dart';
// // // import 'package:task_manager/domain/repositories/task_repository.dart';
// // // import 'package:task_manager/screens/projects/task_repository.dart' show TaskRepository;

// // // import '../../core/services/secure_storage_service.dart';
// // // import '../../data/datasources/mock/mock_data_source.dart';
// // // import '../../domain/repositories/auth_repository.dart';

// // // class InitialBinding extends Bindings {
// // //   @override
// // //   void dependencies() {
// // //     // Data Source
// // //     Get.put<MockDataSource>(
// // //       MockDataSource(),
// // //       permanent: true,
// // //     );

// // //     // Services
// // //     Get.put<SecureStorageService>(
// // //       SecureStorageService(),
// // //       permanent: true,
// // //     );

// // //     // Repository
// // //     Get.put<AuthRepository>(
// // //       AuthRepositoryImpl(
// // //         mockDataSource:
// // //             Get.find<MockDataSource>(),
// // //         secureStorage:
// // //             Get.find<SecureStorageService>(),
// // //       ),
// // //       permanent: true,
// // //     );
// // //     Get.put<TaskRepository>(
// // //   TaskRepositoryImpl(
// // //     mockDataSource:
// // //         Get.find<MockDataSource>(),
// // //   ),
// // //   permanent: true,
// // // );

// // // Get.put<TaskController>(
// // //   TaskController(
// // //     repository:
// // //         Get.find<TaskRepository>(),
// // //   ),
// // //   permanent: true,
// // // );

// // //   Get.put<MockDataSource>(
// // //       MockDataSource(),
// // //       permanent: true,
// // //     );

// // //     // Secure Storage
// // //     Get.put<SecureStorageService>(
// // //       SecureStorageService(),
// // //       permanent: true,
// // //     );

// // //     // Repository
// // //     Get.put<AuthRepository>(
// // //       AuthRepositoryImpl(
// // //         mockDataSource:
// // //             Get.find<MockDataSource>(),
// // //         secureStorage:
// // //             Get.find<SecureStorageService>(),
// // //       ),
// // //       permanent: true,
// // //     );

// // //     // Controller
// // //     Get.put<AuthController>(
// // //       AuthController(
// // //         repository:
// // //             Get.find<AuthRepository>(),
// // //       ),
// // //       permanent: true,
// // //     );
// // //   }
// // // }


// // import 'package:get/get.dart';

// // import 'package:task_manager/controller/auth_controller.dart';
// // import 'package:task_manager/controller/task_controller.dart';

// // import 'package:task_manager/core/services/secure_storage_service.dart';

// // import 'package:task_manager/data/datasources/mock/mock_data_source.dart';




// // import 'package:task_manager/repositories/auth_repository.dart';
// // import 'package:task_manager/repositories/auth_repository_impl.dart';
// // import 'package:task_manager/repositories/task_repository.dart';

// // import 'package:task_manager/screens/projects/project_repo.dart';

// // class InitialBinding extends Bindings {
// //   @override
// //   void dependencies() {
// //     // ==========================================================
// //     // DATA SOURCE
// //     // ==========================================================

// //     Get.put<MockDataSource>(
// //       MockDataSource(),
// //       permanent: true,
// //     );

// //     // ==========================================================
// //     // SERVICES
// //     // ==========================================================

// //     Get.put<SecureStorageService>(
// //       SecureStorageService(),
// //       permanent: true,
// //     );

// //     // ==========================================================
// //     // AUTH REPOSITORY
// //     // ==========================================================

// //     Get.put<AuthRepository>(
// //       AuthRepositoryImpl(
// //         mockDataSource: Get.find<MockDataSource>(),
// //         secureStorage: Get.find<SecureStorageService>(),
// //       ),
// //       permanent: true,
// //     );

// //     // ==========================================================
// //     // TASK REPOSITORY
// //     // ==========================================================

// //     Get.put<TaskRepository>(
// //       TaskRepositoryImpl(
// //         mockDataSource: Get.find<MockDataSource>(),
// //       ),
// //       permanent: true,
// //     );

// //     // ==========================================================
// //     // AUTH CONTROLLER
// //     // ==========================================================

// //     Get.put<AuthController>(
// //       AuthController(
// //         repository: Get.find<AuthRepository>(),
// //       ),
// //       permanent: true,
// //     );

// //     // ==========================================================
// //     // TASK CONTROLLER
// //     // ==========================================================

// //     Get.put<TaskController>(
// //       TaskController(
// //         repository: Get.find<TaskRepository>(),
// //       ),
// //       permanent: true,
// //     );
// //   }
// // }

// import 'package:get/get.dart';

// import 'package:task_manager/controller/auth_controller.dart';
// import 'package:task_manager/controller/task_controller.dart';

// import 'package:task_manager/core/services/secure_storage_service.dart';
// import 'package:task_manager/data/datasources/mock/mock_data_source.dart';

// import 'package:task_manager/repositories/auth_repository.dart';
// import 'package:task_manager/repositories/auth_repository_impl.dart';
// import 'package:task_manager/repositories/task_repository.dart';
// import 'package:task_manager/repositories/task_repository_impl.dart';
// // import 'package:task_manager/screens/projects/task_repo.dart';

// class InitialBinding extends Bindings {
//   @override
//   void dependencies() {
//     print('========== INITIAL BINDING START ==========');

//     Get.put<MockDataSource>(
//       MockDataSource(),
//       permanent: true,
//     );

//     print('MockDataSource registered');

//     Get.put<SecureStorageService>(
//       SecureStorageService(),
//       permanent: true,
//     );

//     print('SecureStorageService registered');

//     Get.put<AuthRepository>(
//       AuthRepositoryImpl(
//         mockDataSource: Get.find<MockDataSource>(),
//         secureStorage: Get.find<SecureStorageService>(),
//       ),
//       permanent: true,
//     );

//     print('AuthRepository registered');

//     Get.put<TaskRepository>(
//       TaskRepositoryImpl(
//         mockDataSource: Get.find<MockDataSource>(),
//       ),
//       permanent: true,
//     );

//     print('TaskRepository registered');

//     Get.put<AuthController>(
//       AuthController(
//         repository: Get.find<AuthRepository>(),
//       ),
//       permanent: true,
//     );

//     print('AuthController registered');

//     Get.put<TaskController>(
//       TaskController(
//         repository: Get.find<TaskRepository>(),
//       ),
//       permanent: true,
//     );

//     print('TaskController registered');

//     print(
//       'TaskController exists: '
//       '${Get.isRegistered<TaskController>()}',
//     );

//     print('========== INITIAL BINDING END ==========');
//   }
// }

// import 'package:get/get.dart';

// import '../../controller/auth_controller.dart';
// import '../../core/services/secure_storage_service.dart';
// import '../../data/datasources/mock/mock_data_source.dart';

// import '../../repositories/auth_repository.dart';
// import '../../repositories/auth_repository_impl.dart';

// class InitialBinding extends Bindings {
//   @override
//   void dependencies() {
//     // ============================================
//     // DATA SOURCE
//     // ============================================

//     Get.put<MockDataSource>(
//       MockDataSource(),
//       permanent: true,
//     );

//     // ============================================
//     // SERVICES
//     // ============================================

//     Get.put<SecureStorageService>(
//       SecureStorageService(),
//       permanent: true,
//     );

//     // ============================================
//     // AUTH REPOSITORY
//     // ============================================

//     Get.put<AuthRepository>(
//       AuthRepositoryImpl(
//         mockDataSource: Get.find<MockDataSource>(),
//         secureStorage: Get.find<SecureStorageService>(),
//       ),
//       permanent: true,
//     );

//     // ============================================
//     // AUTH CONTROLLER
//     // ============================================

//     Get.put<AuthController>(
//       AuthController(
//         repository: Get.find<AuthRepository>(),
//       ),
//       permanent: true,
//     );
//   }
// } 



// import 'package:get/get.dart';

// import 'package:task_manager/controller/auth_controller.dart';
// import 'package:task_manager/controller/project_controller.dart';
// import 'package:task_manager/controller/task_controller.dart';

// import 'package:task_manager/core/services/secure_storage_service.dart';
// import 'package:task_manager/data/datasources/mock/mock_data_source.dart';

// import 'package:task_manager/repositories/auth_repository.dart';
// import 'package:task_manager/repositories/auth_repository_impl.dart';

// import 'package:task_manager/repositories/project_repository.dart';
// import 'package:task_manager/repositories/project_repository_impl.dart';

// import 'package:task_manager/repositories/task_repository.dart';
// import 'package:task_manager/repositories/task_repository_impl.dart';

// class InitialBinding extends Bindings {
//   @override
//   void dependencies() {
//     print('🔥🔥🔥 INITIAL BINDING CALLED 🔥🔥🔥');

//     // DATA SOURCE
//     Get.put<MockDataSource>(
//       MockDataSource(),
//       permanent: true,
//     );

//     print('✅ MockDataSource');

//     // STORAGE
//     Get.put<SecureStorageService>(
//       SecureStorageService(),
//       permanent: true,
//     );

//     print('✅ SecureStorageService');

//     // AUTH REPOSITORY
//     Get.put<AuthRepository>(
//       AuthRepositoryImpl(
//         mockDataSource: Get.find<MockDataSource>(),
//         secureStorage: Get.find<SecureStorageService>(),
//       ),
//       permanent: true,
//     );

//     print('✅ AuthRepository');

//     // PROJECT REPOSITORY
//     Get.put<ProjectRepository>(
//       ProjectRepositoryImpl(
//         mockDataSource: Get.find<MockDataSource>(),
//       ),
//       permanent: true,
//     );

//     print('✅ ProjectRepository');

//     // TASK REPOSITORY
//     Get.put<TaskRepository>(
//       TaskRepositoryImpl(
//         mockDataSource: Get.find<MockDataSource>(),
//       ),
//       permanent: true,
//     );

//     print('✅ TaskRepository');

//     // AUTH CONTROLLER
//     Get.put<AuthController>(
//       AuthController(
//         repository: Get.find<AuthRepository>(),
//       ),
//       permanent: true,
//     );

//     print('✅ AuthController');

//     // PROJECT CONTROLLER
//     Get.put<ProjectController>(
//       ProjectController(
//         repository: Get.find<ProjectRepository>(),
//       ),
//       permanent: true,
//     );

//     print(
//       '✅ ProjectController = '
//       '${Get.isRegistered<ProjectController>()}',
//     );

//     // TASK CONTROLLER
//     Get.put<TaskController>(
//       TaskController(
//         repository: Get.find<TaskRepository>(),
//       ),
//       permanent: true,
//     );

//     print('🚀 BEFORE TASK CONTROLLER');

// Get.put<TaskController>(
//   TaskController(
//     repository: Get.find<TaskRepository>(),
//   ),
//   permanent: true,
// );

// print(
//   '✅ TaskController = '
//   '${Get.isRegistered<TaskController>()}',
// );

// print('🚀 AFTER TASK CONTROLLER');

//     print(
//       '✅ TaskController = '
//       '${Get.isRegistered<TaskController>()}',
//     );

//     print('🔥🔥🔥 INITIAL BINDING FINISHED 🔥🔥🔥');
//   }
// }



import 'package:get/get.dart';

import 'package:task_manager/controller/auth_controller.dart';
import 'package:task_manager/controller/project_controller.dart';
import 'package:task_manager/controller/task_controller.dart';

import 'package:task_manager/core/services/secure_storage_service.dart';
import 'package:task_manager/data/datasources/mock/mock_data_source.dart';

import 'package:task_manager/repositories/auth_repository.dart';
import 'package:task_manager/repositories/auth_repository_impl.dart';

import 'package:task_manager/repositories/project_repository.dart';
import 'package:task_manager/repositories/project_repository_impl.dart';

import 'package:task_manager/repositories/task_repository.dart';
import 'package:task_manager/repositories/task_repository_impl.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    print('========== INITIAL BINDING CALLED ==========');

    // 1. DATA SOURCE
    Get.put<MockDataSource>(
      MockDataSource(),
      permanent: true,
    );

    print('✅ MockDataSource');

    // 2. SECURE STORAGE
    Get.put<SecureStorageService>(
      SecureStorageService(),
      permanent: true,
    );

    print('✅ SecureStorageService');

    // 3. AUTH REPOSITORY
    Get.put<AuthRepository>(
      AuthRepositoryImpl(
        mockDataSource: Get.find<MockDataSource>(),
        secureStorage: Get.find<SecureStorageService>(),
      ),
      permanent: true,
    );

    print('✅ AuthRepository');

    // 4. PROJECT REPOSITORY
    Get.put<ProjectRepository>(
      ProjectRepositoryImpl(
        mockDataSource: Get.find<MockDataSource>(),
      ),
      permanent: true,
    );

    print('✅ ProjectRepository');

    // 5. TASK REPOSITORY
    Get.put<TaskRepository>(
      TaskRepositoryImpl(
        mockDataSource: Get.find<MockDataSource>(),
      ),
      permanent: true,
    );

    print('✅ TaskRepository');

    // 6. AUTH CONTROLLER
    Get.put<AuthController>(
      AuthController(
        repository: Get.find<AuthRepository>(),
      ),
      permanent: true,
    );

    print('✅ AuthController');

    // 7. PROJECT CONTROLLER
    Get.put<ProjectController>(
      ProjectController(
        repository: Get.find<ProjectRepository>(),
      ),
      permanent: true,
    );

    print(
      '✅ ProjectController = '
      '${Get.isRegistered<ProjectController>()}',
    );

    // ==============================
    // DEBUG: TASK CONTROLLER
    // ==============================

    print('🚀 BEFORE TASK CONTROLLER');

    // 8. TASK CONTROLLER
    Get.put<TaskController>(
      TaskController(
        repository: Get.find<TaskRepository>(),
      ),
      permanent: true,
    );

    print(
      '✅ TaskController = '
      '${Get.isRegistered<TaskController>()}',
    );

    print('🚀 AFTER TASK CONTROLLER');

    print('========== INITIAL BINDING FINISHED ==========');
  }
}