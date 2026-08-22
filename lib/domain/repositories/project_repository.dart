import '../../data/models/project_model.dart';

abstract class ProjectRepository {
  Future<List<ProjectModel>> getProjects(
    String organizationId,
  );

  Future<ProjectModel?> getProjectById(
    String projectId,
  );

  Future<ProjectModel> createProject(
    ProjectModel project,
  );

  Future<ProjectModel> updateProject(
    ProjectModel project,
  );

  Future<void> deleteProject(
    String projectId, {
    required String userId,
    required String organizationId,
  });
}