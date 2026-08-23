
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

//   // ============================================================
//   // LOAD MOCK DATA
//   // ============================================================

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

  
//   Future<Map<String, dynamic>> login({
//     required String email,
//     required String password,
//   }) async {
//     await Future.delayed(
//       const Duration(seconds: 1),
//     );

//     final data = await _loadData();

//     final authMock = Map<String, dynamic>.from(
//       data['auth_mock'] ?? {},
//     );

//     final credentials =
//         List<Map<String, dynamic>>.from(
//       authMock['test_credentials'] ?? [],
//     );

//     Map<String, dynamic>? matchedCredential;

//     for (final credential in credentials) {
//       final mockEmail = credential['email']
//           .toString()
//           .trim()
//           .toLowerCase();

//       final mockPassword = credential['password']
//           .toString()
//           .trim();

//       if (mockEmail ==
//               email.trim().toLowerCase() &&
//           mockPassword == password.trim()) {
//         matchedCredential = credential;
//         break;
//       }
//     }

//     if (matchedCredential == null) {
//       throw Exception(
//         'Invalid email or password',
//       );
//     }

//     // Find complete user information
//     final users = await getUsers();

//     UserModel? matchedUser;

//     for (final user in users) {
//       if (user.email.trim().toLowerCase() ==
//           email.trim().toLowerCase()) {
//         matchedUser = user;
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
//       'organization_id':
//           matchedCredential['org_id'],
//       'role':
//           matchedCredential['role'],

//       'access_token':
//           'mock_access_token_${matchedUser.id}',

//       'refresh_token':
//           'mock_refresh_token_${matchedUser.id}',

//       'expires_at': DateTime.now()
//           .add(
//             const Duration(hours: 1),
//           )
//           .toIso8601String(),
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

//   // GET TASK BY ID

//   Future<TaskModel?> getTaskById(
//     String taskId,
//   ) async {
//     final tasks = await getTasks();

//     for (final task in tasks) {
//       if (task.id == taskId) {
//         return task;
//       }
//     }

//     return null;
//   }

//   // GET ALL TASKS OF A PROJECT

//   Future<List<TaskModel>> getTasksByProject(
//     String projectId,
//   ) async {
//     final tasks = await getTasks();

//     return tasks
//         .where(
//           (task) =>
//               task.projectId == projectId,
//         )
//         .toList();
//   }

//   // ADD TASK

//   Future<TaskModel> addTask(
//     TaskModel task,
//   ) async {
//     final tasks = await getTasks();

//     tasks.add(task);

//     _tasks = tasks;

//     return task;
//   }

//   // UPDATE TASK

//   Future<TaskModel> updateTask(
//     TaskModel task,
//   ) async {
//     final tasks = await getTasks();

//     final index = tasks.indexWhere(
//       (item) => item.id == task.id,
//     );

//     if (index == -1) {
//       throw Exception(
//         'Task not found',
//       );
//     }

//     tasks[index] = task;

//     _tasks = tasks;

//     return task;
//   }

//   // DELETE TASK

//   Future<void> deleteTask(
//     String taskId,
//   ) async {
//     final tasks = await getTasks();

//     final exists = tasks.any(
//       (task) => task.id == taskId,
//     );

//     if (!exists) {
//       throw Exception(
//         'Task not found',
//       );
//     }

//     tasks.removeWhere(
//       (task) => task.id == taskId,
//     );

//     _tasks = tasks;
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
      print('📦 Using cached mock data');
      return _mockData!;
    }

    print('📂 Loading JSON from: ${AssetConstants.mockData}');

    final jsonString = await rootBundle.loadString(
      AssetConstants.mockData,
    );

    print('📄 JSON loaded successfully');
    print('📏 JSON length: ${jsonString.length}');

    _mockData =
        jsonDecode(jsonString) as Map<String, dynamic>;

    print('🔑 JSON Keys: ${_mockData!.keys.toList()}');

    return _mockData!;
  }

  // ============================================================
  // LOGIN
  // ============================================================

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    print('');
    print('========== LOGIN START ==========');
    print('Email: $email');

    final data = await _loadData();

    final authMock = Map<String, dynamic>.from(
      data['auth_mock'] ?? {},
    );

    final credentials =
        List<Map<String, dynamic>>.from(
      authMock['test_credentials'] ?? [],
    );

    print(
      'Total credentials: ${credentials.length}',
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
          mockPassword ==
              password.trim()) {
        matchedCredential = credential;
        break;
      }
    }

    if (matchedCredential == null) {
      print('❌ Invalid credentials');

      throw Exception(
        'Invalid email or password',
      );
    }

    print('✅ Credential matched');
    print(
      'Organization ID: ${matchedCredential['org_id']}',
    );

    final users = await getUsers();

    UserModel? matchedUser;

    for (final user in users) {
      if (user.email
              .trim()
              .toLowerCase() ==
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

    print('✅ User found: ${matchedUser.id}');
    print('========== LOGIN END ==========');

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

  // ============================================================
  // AUTH MOCK DATA
  // ============================================================

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

    print(
      '🏢 Total Organizations: '
      '${organizations.length}',
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

    print(
      '👤 Total Users: ${users.length}',
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

    print(
      '👥 Total Org Members: '
      '${members.length}',
    );

    return members
        .map(OrgMemberModel.fromJson)
        .toList();
  }

  // ============================================================
  // PROJECTS
  // ============================================================

  Future<List<ProjectModel>> getProjects() async {
    print('');
    print('========== MOCK DATA PROJECTS START ==========');

    if (_projects != null) {
      print(
        '📦 Returning cached projects: '
        '${_projects!.length}',
      );

      for (final project in _projects!) {
        print(
          'Cached Project: '
          '${project.name}',
        );

        print(
          'ID: ${project.id}',
        );

        print(
          'Organization ID: '
          '${project.organizationId}',
        );
      }

      return List.from(_projects!);
    }

    final data = await _loadData();

    print(
      'Available JSON keys: '
      '${data.keys.toList()}',
    );

    final rawProjects =
        List<Map<String, dynamic>>.from(
      data['projects'] ?? [],
    );

    print(
      '📊 Total RAW Projects: '
      '${rawProjects.length}',
    );

    print('');

    // RAW JSON DEBUG
    for (final projectJson in rawProjects) {
      print('---------- RAW PROJECT JSON ----------');
      print(projectJson);
      print(
        'id = ${projectJson['id']}',
      );

      print(
        'organization_id = '
        '${projectJson['organization_id']}',
      );

      print(
        'organizationId = '
        '${projectJson['organizationId']}',
      );

      print('-------------------------------------');
    }

    _projects = rawProjects
        .map(ProjectModel.fromJson)
        .toList();

    print('');
    print('========== PARSED PROJECTS ==========');

    for (final project in _projects!) {
      print(
        'Project Name: ${project.name}',
      );

      print(
        'Project ID: ${project.id}',
      );

      print(
        'Parsed Organization ID: '
        '${project.organizationId}',
      );

      print('-----------------------------');
    }

    print(
      '========== MOCK DATA PROJECTS END ==========',
    );

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

    print(
      '➕ Project added: ${project.name}',
    );

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
      throw Exception(
        'Project not found',
      );
    }

    projects[index] = project;

    _projects = projects;

    print(
      '✏️ Project updated: ${project.name}',
    );

    return project;
  }

  Future<void> deleteProject(
    String projectId,
  ) async {
    final projects = await getProjects();

    final exists = projects.any(
      (project) =>
          project.id == projectId,
    );

    if (!exists) {
      throw Exception(
        'Project not found',
      );
    }

    projects.removeWhere(
      (project) =>
          project.id == projectId,
    );

    _projects = projects;

    print(
      '🗑️ Project deleted: $projectId',
    );
  }

  // ============================================================
  // TASKS
  // ============================================================

  Future<List<TaskModel>> getTasks() async {
    print('');
    print('========== MOCK DATA TASKS START ==========');

    if (_tasks != null) {
      print(
        '📦 Returning cached tasks: '
        '${_tasks!.length}',
      );

      return List.from(_tasks!);
    }

    final data = await _loadData();

    final rawTasks =
        List<Map<String, dynamic>>.from(
      data['tasks'] ?? [],
    );

    print(
      '📊 Total RAW Tasks: '
      '${rawTasks.length}',
    );

    for (final taskJson in rawTasks) {
      print('---------- RAW TASK ----------');
      print(taskJson);
      print(
        'Project ID: '
        '${taskJson['project_id']}',
      );
    }

    _tasks = rawTasks
        .map(TaskModel.fromJson)
        .toList();

    print('');
    print('========== PARSED TASKS ==========');

    for (final task in _tasks!) {
      print(
        'Task: ${task.title}',
      );

      print(
        'Task ID: ${task.id}',
      );

      print(
        'Project ID: ${task.projectId}',
      );

      print('-----------------------------');
    }

    print(
      '========== MOCK DATA TASKS END ==========',
    );

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

  Future<List<TaskModel>>
      getTasksByProject(
    String projectId,
  ) async {
    final tasks = await getTasks();

    final filteredTasks = tasks
        .where(
          (task) =>
              task.projectId == projectId,
        )
        .toList();

    print('');
    print(
      '📋 Tasks for Project: $projectId',
    );

    print(
      'Total Tasks Found: '
      '${filteredTasks.length}',
    );

    return filteredTasks;
  }

  // ADD TASK

  Future<TaskModel> addTask(
    TaskModel task,
  ) async {
    final tasks = await getTasks();

    tasks.add(task);

    _tasks = tasks;

    print(
      '➕ Task added: ${task.title}',
    );

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

    print(
      '✏️ Task updated: ${task.title}',
    );

    return task;
  }

  // DELETE TASK

  Future<void> deleteTask(
    String taskId,
  ) async {
    final tasks = await getTasks();

    final exists = tasks.any(
      (task) =>
          task.id == taskId,
    );

    if (!exists) {
      throw Exception(
        'Task not found',
      );
    }

    tasks.removeWhere(
      (task) =>
          task.id == taskId,
    );

    _tasks = tasks;

    print(
      '🗑️ Task deleted: $taskId',
    );
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