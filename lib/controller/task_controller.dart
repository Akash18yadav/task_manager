import 'package:get/get.dart';
import 'package:task_manager/screens/projects/task_repo.dart';
import 'package:uuid/uuid.dart';

import '../../core/enums/view_state.dart';
import '../../data/models/task_model.dart';

class TaskController extends GetxController {
  final TaskRepository repository;

  TaskController({
    required this.repository,
  });

final taskController =
    Get.find<TaskController>();
  final tasks = <TaskModel>[].obs;

  final state = ViewState.initial.obs;

  final errorMessage = ''.obs;

  final selectedTask = Rxn<TaskModel>();

  final selectedStatusFilter = 'all'.obs;

  final selectedPriorityFilter = 'all'.obs;

  Future<void> loadAllTasksForProjects(
  List<String> projectIds,
) async {
  try {
    final allTasks = <TaskModel>[];

    for (final projectId in projectIds) {
      final projectTasks =
          await repository
              .getTasksByProject(
        projectId,
      );

      allTasks.addAll(projectTasks);
    }

    tasks.assignAll(allTasks);
  } catch (_) {
    // Project list ke task count failure
    // se main project screen fail nahi honi chahiye.
  }
}

  Future<void> loadTasks(
    String projectId,
  ) async {
    try {
      state.value = ViewState.loading;

      errorMessage.value = '';

      final result =
          await repository.getTasksByProject(
        projectId,
      );

      tasks.assignAll(result);

      if (tasks.isEmpty) {
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

  Future<void> refreshTasks(
    String projectId,
  ) async {
    try {
      final result =
          await repository.getTasksByProject(
        projectId,
      );

      tasks.assignAll(result);

      if (tasks.isEmpty) {
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

  List<TaskModel> get filteredTasks {
    return tasks.where((task) {
      final statusMatches =
          selectedStatusFilter.value == 'all' ||
              task.status ==
                  selectedStatusFilter.value;

      final priorityMatches =
          selectedPriorityFilter.value == 'all' ||
              task.priority ==
                  selectedPriorityFilter.value;

      return statusMatches &&
          priorityMatches;
    }).toList();
  }

  void changeStatusFilter(
    String value,
  ) {
    selectedStatusFilter.value = value;
  }

  void changePriorityFilter(
    String value,
  ) {
    selectedPriorityFilter.value = value;
  }

  void clearFilters() {
    selectedStatusFilter.value = 'all';
    selectedPriorityFilter.value = 'all';
  }

  Future<void> loadTaskDetails(
    String taskId,
  ) async {
    try {
      selectedTask.value =
          await repository.getTaskById(
        taskId,
      );
    } catch (e) {
      errorMessage.value =
          e.toString();
    }
  }

  Future<void> createTask({
    required String projectId,
    required String organizationId,
    required String title,
    String? description,
    required String priority,
    String? assigneeId,
    DateTime? dueDate,
  }) async {
    try {
      final task = TaskModel(
        id: const Uuid().v4(),
        projectId: projectId,
        organizationId: organizationId,
        title: title,
        description: description,
        status: 'todo',
        priority: priority,
        assigneeId: assigneeId,
        dueDate: dueDate,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final result =
          await repository.createTask(task);

      tasks.add(result);

      state.value = ViewState.success;

      Get.back();

      Get.snackbar(
        'Success',
        'Task created successfully',
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString().replaceFirst(
              'Exception: ',
              '',
            ),
      );
    }
  }

  Future<void> updateTask({
    required TaskModel task,
    required String title,
    String? description,
    required String status,
    required String priority,
    String? assigneeId,
    DateTime? dueDate,
  }) async {
    try {
      final updatedTask =
          task.copyWith(
        title: title,
        description: description,
        status: status,
        priority: priority,
        assigneeId: assigneeId,
        dueDate: dueDate,
        updatedAt: DateTime.now(),
      );

      final result =
          await repository.updateTask(
        updatedTask,
      );

      final index = tasks.indexWhere(
        (item) => item.id == result.id,
      );

      if (index != -1) {
        tasks[index] = result;
      }

      selectedTask.value = result;

      Get.back();

      Get.snackbar(
        'Success',
        'Task updated successfully',
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString().replaceFirst(
              'Exception: ',
              '',
            ),
      );
    }
  }

  Future<void> updateTaskStatus({
    required TaskModel task,
    required String status,
  }) async {
    try {
      final updatedTask =
          task.copyWith(
        status: status,
        updatedAt: DateTime.now(),
      );

      final result =
          await repository.updateTask(
        updatedTask,
      );

      final index = tasks.indexWhere(
        (item) => item.id == result.id,
      );

      if (index != -1) {
        tasks[index] = result;
      }

      selectedTask.value = result;
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
      );
    }
  }

  Future<void> deleteTask({
    required String taskId,
    required String userId,
    required String organizationId,
  }) async {
    try {
      await repository.deleteTask(
        taskId,
        userId: userId,
        organizationId: organizationId,
      );

      tasks.removeWhere(
        (task) => task.id == taskId,
      );

      if (tasks.isEmpty) {
        state.value = ViewState.empty;
      }

      Get.back();

      Get.snackbar(
        'Success',
        'Task deleted successfully',
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

  int getTaskCount(
    String projectId,
  ) {
    return tasks
        .where(
          (task) =>
              task.projectId == projectId,
        )
        .length;
  }
}