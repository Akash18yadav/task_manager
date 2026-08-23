import 'package:task_manager/screens/projects/task_repo.dart';

import '../../data/datasources/mock/mock_data_source.dart';
import '../../data/models/org_member_model.dart';
import '../../data/models/task_model.dart';

class TaskRepositoryImplfunction
    implements TaskRepository {
  final MockDataSource mockDataSource;

  TaskRepositoryImplfunction({
    required this.mockDataSource,
  });

  @override
  Future<List<TaskModel>> getTasksByProject(
    String projectId,
  ) async {
    await Future.delayed(
      const Duration(milliseconds: 500),
    );

    return mockDataSource.getTasksByProject(
      projectId,
    );
  }

  @override
  Future<TaskModel?> getTaskById(
    String taskId,
  ) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
    );

    return mockDataSource.getTaskById(
      taskId,
    );
  }

  @override
  Future<int> getTaskCountByProject(
    String projectId,
  ) async {
    final tasks =
        await mockDataSource.getTasksByProject(
      projectId,
    );

    return tasks.length;
  }

  @override
  Future<TaskModel> createTask(
    TaskModel task,
  ) async {
    await _validateAssignee(
      assigneeId: task.assigneeId,
      organizationId: task.organizationId,
    );

    await Future.delayed(
      const Duration(milliseconds: 500),
    );

    return mockDataSource.addTask(task);
  }

  @override
  Future<TaskModel> updateTask(
    TaskModel task,
  ) async {
    await _validateAssignee(
      assigneeId: task.assigneeId,
      organizationId: task.organizationId,
    );

    await Future.delayed(
      const Duration(milliseconds: 500),
    );

    return mockDataSource.updateTask(task);
  }

  @override
  Future<void> deleteTask(
    String taskId, {
    required String userId,
    required String organizationId,
  }) async {
    final members =
        await mockDataSource.getOrgMembers();

    OrgMemberModel? currentMember;

    for (final member in members) {
      if (member.userId == userId &&
          member.organizationId ==
              organizationId) {
        currentMember = member;
        break;
      }
    }

    if (currentMember == null) {
      throw Exception(
        'User is not a member of organization',
      );
    }

    final task =
        await mockDataSource.getTaskById(
      taskId,
    );

    if (task == null) {
      throw Exception('Task not found');
    }

    // Admin can delete any task.
    // Non-admin can delete only own task.
    final isOwner =
        task.assigneeId == userId;

    if (!currentMember.isAdmin && !isOwner) {
      throw Exception(
        'You do not have permission to delete this task',
      );
    }

    await mockDataSource.deleteTask(taskId);
  }

  Future<void> _validateAssignee({
    required String? assigneeId,
    required String organizationId,
  }) async {
    if (assigneeId == null ||
        assigneeId.isEmpty) {
      return;
    }

    final members =
        await mockDataSource.getOrgMembers();

    final isValidMember = members.any(
      (member) =>
          member.userId == assigneeId &&
          member.organizationId ==
              organizationId,
    );

    if (!isValidMember) {
      throw Exception(
        'Assignee does not belong to this organization',
      );
    }
  }
}