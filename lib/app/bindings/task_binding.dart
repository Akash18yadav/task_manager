import 'package:get/get.dart';

import '../../controller/task_controller.dart';
import '../../data/datasources/mock/mock_data_source.dart';

import '../../repositories/task_repository.dart';
import '../../repositories/task_repository_impl.dart';

class TaskBinding extends Bindings {
  @override
  void dependencies() {
    // Repository

    Get.lazyPut<TaskRepository>(
      () => TaskRepositoryImpl(
        mockDataSource: Get.find<MockDataSource>(),
      ),
      fenix: true,
    );

    // Controller

    Get.lazyPut<TaskController>(
      () => TaskController(
        repository: Get.find<TaskRepository>(),
      ),
      fenix: true,
    );
  }
}