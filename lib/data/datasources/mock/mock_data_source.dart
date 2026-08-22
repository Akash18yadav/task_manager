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

  Future<Map<String, dynamic>>
      getAuthMockData() async {
    final data = await _loadData();

    return Map<String, dynamic>.from(
      data['auth_mock'] ?? {},
    );
  }
}