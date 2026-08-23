import 'package:get/get.dart';

import '../../controller/project_controller.dart';
import '../../data/datasources/mock/mock_data_source.dart';

import '../../repositories/project_repository.dart';
import '../../repositories/project_repository_impl.dart';

class ProjectBinding extends Bindings {
  @override
  void dependencies() {
    // Repository

    Get.lazyPut<ProjectRepository>(
      () => ProjectRepositoryImpl(
        mockDataSource: Get.find<MockDataSource>(),
      ),
      fenix: true,
    );

    // Controller

    Get.lazyPut<ProjectController>(
      () => ProjectController(
        repository: Get.find<ProjectRepository>(),
      ),
      fenix: true,
    );
  }
}