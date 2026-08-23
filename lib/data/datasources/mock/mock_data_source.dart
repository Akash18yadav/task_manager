

// import 'dart:convert';

// import 'package:flutter/services.dart';

// import '../../../core/constants/asset_constants.dart';
// import '../../models/comment_model.dart';
// import '../../models/notification_model.dart';
// import '../../models/org_member_model.dart';
// import '../../models/organization_model.dart';
// import '../../models/project_model.dart';
// import '../../models/task_model.dart';
// import '../../models/user_model.dart';

// class MockDataSource {
//   Map<String, dynamic>? _mockData;

//   List<ProjectModel>? _projects;
//   List<TaskModel>? _tasks;

//   Future<Map<String, dynamic>> _loadData() async {
//     if (_mockData != null) {
//       return _mockData!;
//     }

//     final jsonString = await rootBundle.loadString(
//       AssetConstants.mockData,
//     );

//     _mockData = jsonDecode(jsonString)
//         as Map<String, dynamic>;

//     return _mockData!;
//   }

//   // ============================================================
//   // AUTH
//   // ============================================================

//   Future<Map<String, dynamic>> login({
//     required String email,
//     required String password,
//   }) async {
//     // Simulate API delay
//     await Future.delayed(
//       const Duration(seconds: 1),
//     );

//     final data = await _loadData();

//     final authMock =
//         Map<String, dynamic>.from(
//       data['auth_mock'] ?? {},
//     );

//     final credentials =
//         List<Map<String, dynamic>>.from(
//       authMock['test_credentials'] ?? [],
//     );

//     final user = credentials.cast<Map<String, dynamic>?>().firstWhere(
//       (item) {
//         if (item == null) {
//           return false;
//         }

//         return item['email']
//                     .toString()
//                     .toLowerCase() ==
//                 email.trim().toLowerCase() &&
//             item['password'].toString() == password;
//       },
//       orElse: () => null,
//     );

//     if (user == null) {
//       throw Exception(
//         'Invalid email or password',
//       );
//     }

//     // Find complete user information
//     final users = await getUsers();

//     UserModel? matchedUser;

//     for (final item in users) {
//       if (item.email.toLowerCase() ==
//           email.trim().toLowerCase()) {
//         matchedUser = item;
//         break;
//       }
//     }

//     if (matchedUser == null) {
//       throw Exception(
//         'User not found in mock data',
//       );
//     }

//     return {
//       'user_id': matchedUser.id,
//       'organization_id': user['org_id'],
//       'role': user['role'],

//       // Mock tokens
//       'access_token':
//           'mock_access_token_${matchedUser.id}',

//       'refresh_token':
//           'mock_refresh_token_${matchedUser.id}',

//       // 1 hour expiry
//       'expires_at':
//           DateTime.now()
//               .add(
//                 const Duration(hours: 1),
//               )
//               .toIso8601String(),
//     };
//   }

//   Future<Map<String, dynamic>>
//       getAuthMockData() async {
//     final data = await _loadData();

//     return Map<String, dynamic>.from(
//       data['auth_mock'] ?? {},
//     );
//   }

//   // ============================================================
//   // ORGANIZATIONS
//   // ============================================================

//   Future<List<OrganizationModel>>
//       getOrganizations() async {
//     final data = await _loadData();

//     final organizations =
//         List<Map<String, dynamic>>.from(
//       data['organizations'] ?? [],
//     );

//     return organizations
//         .map(OrganizationModel.fromJson)
//         .toList();
//   }

//   // ============================================================
//   // USERS
//   // ============================================================

//   Future<List<UserModel>> getUsers() async {
//     final data = await _loadData();

//     final users =
//         List<Map<String, dynamic>>.from(
//       data['users'] ?? [],
//     );

//     return users
//         .map(UserModel.fromJson)
//         .toList();
//   }

//   // ============================================================
//   // ORGANIZATION MEMBERS
//   // ============================================================

//   Future<List<OrgMemberModel>>
//       getOrgMembers() async {
//     final data = await _loadData();

//     final members =
//         List<Map<String, dynamic>>.from(
//       data['org_members'] ?? [],
//     );

//     return members
//         .map(OrgMemberModel.fromJson)
//         .toList();
//   }

//   // ============================================================
//   // PROJECTS
//   // ============================================================

//   Future<List<ProjectModel>>
//       getProjects() async {
//     if (_projects != null) {
//       return List.from(_projects!);
//     }

//     final data = await _loadData();

//     final projects =
//         List<Map<String, dynamic>>.from(
//       data['projects'] ?? [],
//     );

//     _projects = projects
//         .map(ProjectModel.fromJson)
//         .toList();

//     return List.from(_projects!);
//   }

//   Future<ProjectModel?> getProjectById(
//     String projectId,
//   ) async {
//     final projects = await getProjects();

//     for (final project in projects) {
//       if (project.id == projectId) {
//         return project;
//       }
//     }

//     return null;
//   }

//   Future<ProjectModel> addProject(
//     ProjectModel project,
//   ) async {
//     final projects = await getProjects();

//     projects.add(project);

//     _projects = projects;

//     return project;
//   }

//   Future<ProjectModel> updateProject(
//     ProjectModel project,
//   ) async {
//     final projects = await getProjects();

//     final index = projects.indexWhere(
//       (item) => item.id == project.id,
//     );

//     if (index == -1) {
//       throw Exception('Project not found');
//     }

//     projects[index] = project;

//     _projects = projects;

//     return project;
//   }

//   Future<void> deleteProject(
//     String projectId,
//   ) async {
//     final projects = await getProjects();

//     final exists = projects.any(
//       (project) => project.id == projectId,
//     );

//     if (!exists) {
//       throw Exception('Project not found');
//     }

//     projects.removeWhere(
//       (project) => project.id == projectId,
//     );

//     _projects = projects;
//   }

//   // ============================================================
//   // TASKS
//   // ============================================================

//   Future<List<TaskModel>> getTasks() async {
//     if (_tasks != null) {
//       return List.from(_tasks!);
//     }

//     final data = await _loadData();

//     final tasks =
//         List<Map<String, dynamic>>.from(
//       data['tasks'] ?? [],
//     );

//     _tasks = tasks
//         .map(TaskModel.fromJson)
//         .toList();

//     return List.from(_tasks!);
//   }

//   // ============================================================
//   // COMMENTS
//   // ============================================================

//   Future<List<CommentModel>>
//       getComments() async {
//     final data = await _loadData();

//     final comments =
//         List<Map<String, dynamic>>.from(
//       data['comments'] ?? [],
//     );

//     return comments
//         .map(CommentModel.fromJson)
//         .toList();
//   }

//   // ============================================================
//   // NOTIFICATIONS
//   // ============================================================

//   Future<List<NotificationModel>>
//       getNotifications() async {
//     final data = await _loadData();

//     final notifications =
//         List<Map<String, dynamic>>.from(
//       data['notifications'] ?? [],
//     );

//     return notifications
//         .map(NotificationModel.fromJson)
//         .toList();
//   }
// }
import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../core/constants/asset_constants.dart';
import '../../models/comment_model.dart';
import '../../models/notification_model.dart';
import '../../models/org_member_model.dart';
import '../../models/organization_model.dart';
import '../../models/project_model.dart';
import '../../models/task_model.dart';
import '../../models/user_model.dart';

class MockDataSource {
  Map<String, dynamic>? _mockData;

  List<ProjectModel>? _projects;
  List<TaskModel>? _tasks;

  // ============================================================
  // LOAD MOCK DATA
  // ============================================================

  Future<Map<String, dynamic>> _loadData() async {
    if (_mockData != null) {
      return _mockData!;
    }

    final jsonString = await rootBundle.loadString(
      AssetConstants.mockData,
    );

    _mockData = jsonDecode(jsonString)
        as Map<String, dynamic>;

    return _mockData!;
  }

  // ============================================================
  // AUTH
  // ============================================================

  // Future<Map<String, dynamic>> login({
  //   required String email,
  //   required String password,
  // }) async {
  //   await Future.delayed(
  //     const Duration(seconds: 1),
  //   );

  //   final data = await _loadData();

  //   final authMock = Map<String, dynamic>.from(
  //     data['auth_mock'] ?? {},
  //   );

  //   final credentials =
  //       List<Map<String, dynamic>>.from(
  //     authMock['test_credentials'] ?? [],
  //   );

  //   Map<String, dynamic>? matchedCredential;

  //   for (final credential in credentials) {
  //     final mockEmail = credential['email']
  //         .toString()
  //         .trim()
  //         .toLowerCase();

  //     final mockPassword = credential['password']
  //         .toString()
  //         .trim();

  //     if (mockEmail ==
  //             email.trim().toLowerCase() &&
  //         mockPassword == password.trim()) {
  //       matchedCredential = credential;
  //       break;
  //     }
  //   }

  //   if (matchedCredential == null) {
  //     throw Exception(
  //       'Invalid email or password',
  //     );
  //   }

  //   // Find complete user information
  //   final users = await getUsers();

  //   UserModel? matchedUser;

  //   for (final user in users) {
  //     if (user.email.trim().toLowerCase() ==
  //         email.trim().toLowerCase()) {
  //       matchedUser = user;
  //       break;
  //     }
  //   }

  //   if (matchedUser == null) {
  //     throw Exception(
  //       'User not found in mock data',
  //     );
  //   }

  //   return {
  //     'user_id': matchedUser.id,
  //     'organization_id':
  //         matchedCredential['org_id'],
  //     'role':
  //         matchedCredential['role'],

  //     'access_token':
  //         'mock_access_token_${matchedUser.id}',

  //     'refresh_token':
  //         'mock_refresh_token_${matchedUser.id}',

  //     'expires_at': DateTime.now()
  //         .add(
  //           const Duration(hours: 1),
  //         )
  //         .toIso8601String(),
  //   };
  // }

  
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    final data = await _loadData();

    final authMock = Map<String, dynamic>.from(
      data['auth_mock'] ?? {},
    );

    final credentials =
        List<Map<String, dynamic>>.from(
      authMock['test_credentials'] ?? [],
    );

    Map<String, dynamic>? matchedCredential;

    for (final credential in credentials) {
      final mockEmail = credential['email']
          .toString()
          .trim()
          .toLowerCase();

      final mockPassword = credential['password']
          .toString()
          .trim();

      if (mockEmail ==
              email.trim().toLowerCase() &&
          mockPassword == password.trim()) {
        matchedCredential = credential;
        break;
      }
    }

    if (matchedCredential == null) {
      throw Exception(
        'Invalid email or password',
      );
    }

    // Find complete user information
    final users = await getUsers();

    UserModel? matchedUser;

    for (final user in users) {
      if (user.email.trim().toLowerCase() ==
          email.trim().toLowerCase()) {
        matchedUser = user;
        break;
      }
    }

    if (matchedUser == null) {
      throw Exception(
        'User not found in mock data',
      );
    }

    return {
      'user_id': matchedUser.id,
      'organization_id':
          matchedCredential['org_id'],
      'role':
          matchedCredential['role'],

      'access_token':
          'mock_access_token_${matchedUser.id}',

      'refresh_token':
          'mock_refresh_token_${matchedUser.id}',

      'expires_at': DateTime.now()
          .add(
            const Duration(hours: 1),
          )
          .toIso8601String(),
    };
  }


  Future<Map<String, dynamic>>
      getAuthMockData() async {
    final data = await _loadData();

    return Map<String, dynamic>.from(
      data['auth_mock'] ?? {},
    );
  }

  // ============================================================
  // ORGANIZATIONS
  // ============================================================

  Future<List<OrganizationModel>>
      getOrganizations() async {
    final data = await _loadData();

    final organizations =
        List<Map<String, dynamic>>.from(
      data['organizations'] ?? [],
    );

    return organizations
        .map(OrganizationModel.fromJson)
        .toList();
  }

  // ============================================================
  // USERS
  // ============================================================

  Future<List<UserModel>> getUsers() async {
    final data = await _loadData();

    final users =
        List<Map<String, dynamic>>.from(
      data['users'] ?? [],
    );

    return users
        .map(UserModel.fromJson)
        .toList();
  }

  // ============================================================
  // ORGANIZATION MEMBERS
  // ============================================================

  Future<List<OrgMemberModel>>
      getOrgMembers() async {
    final data = await _loadData();

    final members =
        List<Map<String, dynamic>>.from(
      data['org_members'] ?? [],
    );

    return members
        .map(OrgMemberModel.fromJson)
        .toList();
  }

  // ============================================================
  // PROJECTS
  // ============================================================

  Future<List<ProjectModel>>
      getProjects() async {
    if (_projects != null) {
      return List.from(_projects!);
    }

    final data = await _loadData();

    final projects =
        List<Map<String, dynamic>>.from(
      data['projects'] ?? [],
    );

    _projects = projects
        .map(ProjectModel.fromJson)
        .toList();

    return List.from(_projects!);
  }

  Future<ProjectModel?> getProjectById(
    String projectId,
  ) async {
    final projects = await getProjects();

    for (final project in projects) {
      if (project.id == projectId) {
        return project;
      }
    }

    return null;
  }

  Future<ProjectModel> addProject(
    ProjectModel project,
  ) async {
    final projects = await getProjects();

    projects.add(project);

    _projects = projects;

    return project;
  }

  Future<ProjectModel> updateProject(
    ProjectModel project,
  ) async {
    final projects = await getProjects();

    final index = projects.indexWhere(
      (item) => item.id == project.id,
    );

    if (index == -1) {
      throw Exception('Project not found');
    }

    projects[index] = project;

    _projects = projects;

    return project;
  }

  Future<void> deleteProject(
    String projectId,
  ) async {
    final projects = await getProjects();

    final exists = projects.any(
      (project) => project.id == projectId,
    );

    if (!exists) {
      throw Exception('Project not found');
    }

    projects.removeWhere(
      (project) => project.id == projectId,
    );

    _projects = projects;
  }

  // ============================================================
  // TASKS
  // ============================================================

  Future<List<TaskModel>> getTasks() async {
    if (_tasks != null) {
      return List.from(_tasks!);
    }

    final data = await _loadData();

    final tasks =
        List<Map<String, dynamic>>.from(
      data['tasks'] ?? [],
    );

    _tasks = tasks
        .map(TaskModel.fromJson)
        .toList();

    return List.from(_tasks!);
  }

  // GET TASK BY ID

  Future<TaskModel?> getTaskById(
    String taskId,
  ) async {
    final tasks = await getTasks();

    for (final task in tasks) {
      if (task.id == taskId) {
        return task;
      }
    }

    return null;
  }

  // GET ALL TASKS OF A PROJECT

  Future<List<TaskModel>> getTasksByProject(
    String projectId,
  ) async {
    final tasks = await getTasks();

    return tasks
        .where(
          (task) =>
              task.projectId == projectId,
        )
        .toList();
  }

  // ADD TASK

  Future<TaskModel> addTask(
    TaskModel task,
  ) async {
    final tasks = await getTasks();

    tasks.add(task);

    _tasks = tasks;

    return task;
  }

  // UPDATE TASK

  Future<TaskModel> updateTask(
    TaskModel task,
  ) async {
    final tasks = await getTasks();

    final index = tasks.indexWhere(
      (item) => item.id == task.id,
    );

    if (index == -1) {
      throw Exception(
        'Task not found',
      );
    }

    tasks[index] = task;

    _tasks = tasks;

    return task;
  }

  // DELETE TASK

  Future<void> deleteTask(
    String taskId,
  ) async {
    final tasks = await getTasks();

    final exists = tasks.any(
      (task) => task.id == taskId,
    );

    if (!exists) {
      throw Exception(
        'Task not found',
      );
    }

    tasks.removeWhere(
      (task) => task.id == taskId,
    );

    _tasks = tasks;
  }

  // ============================================================
  // COMMENTS
  // ============================================================

  Future<List<CommentModel>>
      getComments() async {
    final data = await _loadData();

    final comments =
        List<Map<String, dynamic>>.from(
      data['comments'] ?? [],
    );

    return comments
        .map(CommentModel.fromJson)
        .toList();
  }

  // ============================================================
  // NOTIFICATIONS
  // ============================================================

  Future<List<NotificationModel>>
      getNotifications() async {
    final data = await _loadData();

    final notifications =
        List<Map<String, dynamic>>.from(
      data['notifications'] ?? [],
    );

    return notifications
        .map(NotificationModel.fromJson)
        .toList();
  }
}