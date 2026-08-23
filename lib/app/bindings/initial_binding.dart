// // import 'package:get/get.dart';
// // import 'package:task_manager/controller/auth_controller.dart';
// // import 'package:task_manager/controller/task_controller.dart';
// // import 'package:task_manager/domain/repositories/auth_repository_impl.dart';
// // import 'package:task_manager/domain/repositories/task_repository.dart';
// // import 'package:task_manager/screens/projects/task_repository.dart' show TaskRepository;

// // import '../../core/services/secure_storage_service.dart';
// // import '../../data/datasources/mock/mock_data_source.dart';
// // import '../../domain/repositories/auth_repository.dart';

// // class InitialBinding extends Bindings {
// //   @override
// //   void dependencies() {
// //     // Data Source
// //     Get.put<MockDataSource>(
// //       MockDataSource(),
// //       permanent: true,
// //     );

// //     // Services
// //     Get.put<SecureStorageService>(
// //       SecureStorageService(),
// //       permanent: true,
// //     );

// //     // Repository
// //     Get.put<AuthRepository>(
// //       AuthRepositoryImpl(
// //         mockDataSource:
// //             Get.find<MockDataSource>(),
// //         secureStorage:
// //             Get.find<SecureStorageService>(),
// //       ),
// //       permanent: true,
// //     );
// //     Get.put<TaskRepository>(
// //   TaskRepositoryImpl(
// //     mockDataSource:
// //         Get.find<MockDataSource>(),
// //   ),
// //   permanent: true,
// // );

// // Get.put<TaskController>(
// //   TaskController(
// //     repository:
// //         Get.find<TaskRepository>(),
// //   ),
// //   permanent: true,
// // );

// //   Get.put<MockDataSource>(
// //       MockDataSource(),
// //       permanent: true,
// //     );

// //     // Secure Storage
// //     Get.put<SecureStorageService>(
// //       SecureStorageService(),
// //       permanent: true,
// //     );

// //     // Repository
// //     Get.put<AuthRepository>(
// //       AuthRepositoryImpl(
// //         mockDataSource:
// //             Get.find<MockDataSource>(),
// //         secureStorage:
// //             Get.find<SecureStorageService>(),
// //       ),
// //       permanent: true,
// //     );

// //     // Controller
// //     Get.put<AuthController>(
// //       AuthController(
// //         repository:
// //             Get.find<AuthRepository>(),
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

// import 'package:task_manager/screens/projects/project_repo.dart';

// class InitialBinding extends Bindings {
//   @override
//   void dependencies() {
//     // ==========================================================
//     // DATA SOURCE
//     // ==========================================================

//     Get.put<MockDataSource>(
//       MockDataSource(),
//       permanent: true,
//     );

//     // ==========================================================
//     // SERVICES
//     // ==========================================================

//     Get.put<SecureStorageService>(
//       SecureStorageService(),
//       permanent: true,
//     );

//     // ==========================================================
//     // AUTH REPOSITORY
//     // ==========================================================

//     Get.put<AuthRepository>(
//       AuthRepositoryImpl(
//         mockDataSource: Get.find<MockDataSource>(),
//         secureStorage: Get.find<SecureStorageService>(),
//       ),
//       permanent: true,
//     );

//     // ==========================================================
//     // TASK REPOSITORY
//     // ==========================================================

//     Get.put<TaskRepository>(
//       TaskRepositoryImpl(
//         mockDataSource: Get.find<MockDataSource>(),
//       ),
//       permanent: true,
//     );

//     // ==========================================================
//     // AUTH CONTROLLER
//     // ==========================================================

//     Get.put<AuthController>(
//       AuthController(
//         repository: Get.find<AuthRepository>(),
//       ),
//       permanent: true,
//     );

//     // ==========================================================
//     // TASK CONTROLLER
//     // ==========================================================

//     Get.put<TaskController>(
//       TaskController(
//         repository: Get.find<TaskRepository>(),
//       ),
//       permanent: true,
//     );
//   }
// }

import 'package:get/get.dart';

import 'package:task_manager/controller/auth_controller.dart';
import 'package:task_manager/controller/task_controller.dart';

import 'package:task_manager/core/services/secure_storage_service.dart';
import 'package:task_manager/data/datasources/mock/mock_data_source.dart';

import 'package:task_manager/repositories/auth_repository.dart';
import 'package:task_manager/repositories/auth_repository_impl.dart';
import 'package:task_manager/repositories/task_repository.dart';
import 'package:task_manager/screens/projects/task_repo.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    print('========== INITIAL BINDING START ==========');

    Get.put<MockDataSource>(
      MockDataSource(),
      permanent: true,
    );

    print('MockDataSource registered');

    Get.put<SecureStorageService>(
      SecureStorageService(),
      permanent: true,
    );

    print('SecureStorageService registered');

    Get.put<AuthRepository>(
      AuthRepositoryImpl(
        mockDataSource: Get.find<MockDataSource>(),
        secureStorage: Get.find<SecureStorageService>(),
      ),
      permanent: true,
    );

    print('AuthRepository registered');

    Get.put<TaskRepository>(
      TaskRepositoryImplfunction(
        mockDataSource: Get.find<MockDataSource>(),
      ),
      permanent: true,
    );

    print('TaskRepository registered');

    Get.put<AuthController>(
      AuthController(
        repository: Get.find<AuthRepository>(),
      ),
      permanent: true,
    );

    print('AuthController registered');

    Get.put<TaskController>(
      TaskController(
        repository: Get.find<TaskRepository>(),
      ),
      permanent: true,
    );

    print('TaskController registered');

    print(
      'TaskController exists: '
      '${Get.isRegistered<TaskController>()}',
    );

    print('========== INITIAL BINDING END ==========');
  }
}