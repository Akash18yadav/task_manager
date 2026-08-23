import 'package:get/get.dart';
import 'package:task_manager/controller/auth_controller.dart';
import 'package:task_manager/controller/task_controller.dart';
import 'package:task_manager/domain/repositories/auth_repository_impl.dart';
import 'package:task_manager/domain/repositories/task_repository.dart';
import 'package:task_manager/screens/projects/task_repository.dart' show TaskRepository;

import '../../core/services/secure_storage_service.dart';
import '../../data/datasources/mock/mock_data_source.dart';
import '../../domain/repositories/auth_repository.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Data Source
    Get.put<MockDataSource>(
      MockDataSource(),
      permanent: true,
    );

    // Services
    Get.put<SecureStorageService>(
      SecureStorageService(),
      permanent: true,
    );

    // Repository
    Get.put<AuthRepository>(
      AuthRepositoryImpl(
        mockDataSource:
            Get.find<MockDataSource>(),
        secureStorage:
            Get.find<SecureStorageService>(),
      ),
      permanent: true,
    );
    Get.put<TaskRepository>(
  TaskRepositoryImpl(
    mockDataSource:
        Get.find<MockDataSource>(),
  ),
  permanent: true,
);

Get.put<TaskController>(
  TaskController(
    repository:
        Get.find<TaskRepository>(),
  ),
  permanent: true,
);

  Get.put<MockDataSource>(
      MockDataSource(),
      permanent: true,
    );

    // Secure Storage
    Get.put<SecureStorageService>(
      SecureStorageService(),
      permanent: true,
    );

    // Repository
    Get.put<AuthRepository>(
      AuthRepositoryImpl(
        mockDataSource:
            Get.find<MockDataSource>(),
        secureStorage:
            Get.find<SecureStorageService>(),
      ),
      permanent: true,
    );

    // Controller
    Get.put<AuthController>(
      AuthController(
        repository:
            Get.find<AuthRepository>(),
      ),
      permanent: true,
    );
  }
}