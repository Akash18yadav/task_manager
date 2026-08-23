import '../../data/models/task_model.dart';

abstract class TaskRepository {
  Future<List<TaskModel>> getTasksByProject(
    String projectId,
  );

  Future<TaskModel?> getTaskById(
    String taskId,
  );

  Future<int> getTaskCountByProject(
    String projectId,
  );

  Future<TaskModel> createTask(
    TaskModel task,
  );

  Future<TaskModel> updateTask(
    TaskModel task,
  );

  Future<void> deleteTask(
    String taskId, {
    required String userId,
    required String organizationId,
  });
}