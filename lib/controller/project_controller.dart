import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../core/enums/view_state.dart';
import '../../data/models/project_model.dart';
import '../../domain/repositories/project_repository.dart';

class ProjectController extends GetxController {
  final ProjectRepository repository;

  ProjectController({
    required this.repository,
  });

  final projects = <ProjectModel>[].obs;

  final state = ViewState.initial.obs;

  final errorMessage = ''.obs;

  final selectedProject = Rxn<ProjectModel>();

  Future<void> loadProjects(
    String organizationId,
  ) async {
    try {
      state.value = ViewState.loading;
      errorMessage.value = '';

      final result =
          await repository.getProjects(
        organizationId,
      );

      projects.assignAll(result);

      if (projects.isEmpty) {
        state.value = ViewState.empty;
      } else {
        state.value = ViewState.success;
      }
    } catch (e) {
      errorMessage.value =
          e.toString().replaceFirst(
                'Exception: ',
                '',
              );

      state.value = ViewState.error;
    }
  }

  Future<void> refreshProjects(
    String organizationId,
  ) async {
    try {
      errorMessage.value = '';

      final result =
          await repository.getProjects(
        organizationId,
      );

      projects.assignAll(result);

      if (projects.isEmpty) {
        state.value = ViewState.empty;
      } else {
        state.value = ViewState.success;
      }
    } catch (e) {
      errorMessage.value =
          e.toString().replaceFirst(
                'Exception: ',
                '',
              );

      state.value = ViewState.error;
    }
  }

  Future<void> loadProjectDetails(
    String projectId,
  ) async {
    try {
      selectedProject.value =
          await repository.getProjectById(
        projectId,
      );
    } catch (e) {
      errorMessage.value = e.toString();
    }
  }

  Future<void> createProject({
    required String organizationId,
    required String name,
    String? description,
  }) async {
    try {
      final project = ProjectModel(
        id: const Uuid().v4(),
        organizationId: organizationId,
        name: name,
        description: description,
        status: 'active',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final createdProject =
          await repository.createProject(
        project,
      );

      projects.add(createdProject);

      state.value = ViewState.success;

      Get.back();

      Get.snackbar(
        'Success',
        'Project created successfully',
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
      );
    }
  }

  Future<void> updateProject({
    required ProjectModel project,
    required String name,
    String? description,
    required String status,
  }) async {
    try {
      final updatedProject =
          project.copyWith(
        name: name,
        description: description,
        status: status,
        updatedAt: DateTime.now(),
      );

      final result =
          await repository.updateProject(
        updatedProject,
      );

      final index = projects.indexWhere(
        (item) => item.id == result.id,
      );

      if (index != -1) {
        projects[index] = result;
      }

      selectedProject.value = result;

      Get.back();

      Get.snackbar(
        'Success',
        'Project updated successfully',
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
      );
    }
  }

  Future<void> deleteProject({
    required String projectId,
    required String userId,
    required String organizationId,
  }) async {
    try {
      await repository.deleteProject(
        projectId,
        userId: userId,
        organizationId: organizationId,
      );

      projects.removeWhere(
        (project) => project.id == projectId,
      );

      if (projects.isEmpty) {
        state.value = ViewState.empty;
      }

      Get.back();

      Get.snackbar(
        'Success',
        'Project deleted successfully',
      );
    } catch (e) {
      Get.snackbar(
        'Permission Error',
        e.toString().replaceFirst(
              'Exception: ',
              '',
            ),
      );
    }
  }
}