// // import '../data/datasources/mock/mock_data_source.dart';
// // import '../data/models/project_model.dart';
// // import 'project_repository.dart';

// // class ProjectRepositoryImpl implements ProjectRepository {
// //   final MockDataSource mockDataSource;

// //   ProjectRepositoryImpl({
// //     required this.mockDataSource,
// //   });

// //   @override
// //   Future<List<ProjectModel>> getProjects() async {
// //     return await mockDataSource.getProjects();
// //   }

// //   @override
// //   Future<ProjectModel> createProject(ProjectModel project) {
// //     // TODO: implement createProject
// //     throw UnimplementedError();
// //   }

// //   @override
// //   Future<void> deleteProject(String projectId, {required String userId, required String organizationId}) {
// //     // TODO: implement deleteProject
// //     throw UnimplementedError();
// //   }

// //   @override
// //   Future<ProjectModel?> getProjectById(String projectId) {
// //     // TODO: implement getProjectById
// //     throw UnimplementedError();
// //   }

// //   @override
// //   Future<ProjectModel> updateProject(ProjectModel project) {
// //     // TODO: implement updateProject
// //     throw UnimplementedError();
// //   }
// // }

// import '../data/datasources/mock/mock_data_source.dart';
// import '../data/models/project_model.dart';
// import 'project_repository.dart';

// class ProjectRepositoryImpl implements ProjectRepository {
//   final MockDataSource mockDataSource;

//   ProjectRepositoryImpl({
//     required this.mockDataSource,
//   });

//   @override
//   Future<List<ProjectModel>> getProjects() async {
//     return mockDataSource.getProjects();
//   }

//   @override
//   Future<ProjectModel?> getProjectById(
//     String projectId,
//   ) async {
//     return mockDataSource.getProjectById(
//       projectId,
//     );
//   }

//   @override
//   Future<ProjectModel> addProject(
//     ProjectModel project,
//   ) async {
//     return mockDataSource.addProject(
//       project,
//     );
//   }

//   @override
//   Future<ProjectModel> updateProject(
//     ProjectModel project,
//   ) async {
//     return mockDataSource.updateProject(
//       project,
//     );
//   }

//   @override
//   Future<void> deleteProject(
//     String projectId,
//   ) async {
//     return mockDataSource.deleteProject(
//       projectId,
//     );
//   }

//   @override
//   Future<ProjectModel> createProject(ProjectModel project) {
//     // TODO: implement createProject
//     throw UnimplementedError();
//   }
// }

import '../data/datasources/mock/mock_data_source.dart';
import '../data/models/project_model.dart';
import 'project_repository.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final MockDataSource mockDataSource;

  ProjectRepositoryImpl({
    required this.mockDataSource,
  });

  @override
  Future<List<ProjectModel>> getProjects(
    String organizationId,
  ) async {
    final projects =
        await mockDataSource.getProjects();

    return projects.where(
      (project) =>
          project.organizationId == organizationId,
    ).toList();
  }

  @override
  Future<ProjectModel?> getProjectById(
    String projectId,
  ) async {
    return mockDataSource.getProjectById(
      projectId,
    );
  }

  @override
  Future<ProjectModel> createProject(
    ProjectModel project,
  ) async {
    return mockDataSource.addProject(
      project,
    );
  }

  @override
  Future<ProjectModel> updateProject(
    ProjectModel project,
  ) async {
    return mockDataSource.updateProject(
      project,
    );
  }

  @override
  Future<void> deleteProject(
    String projectId, {
    required String userId,
    required String organizationId,
  }) async {
    final project =
        await mockDataSource.getProjectById(
      projectId,
    );

    if (project == null) {
      throw Exception('Project not found');
    }

    // Check project belongs to organization
    if (project.organizationId != organizationId) {
      throw Exception(
        'Project does not belong to this organization',
      );
    }

    await mockDataSource.deleteProject(
      projectId,
    );
  }
}