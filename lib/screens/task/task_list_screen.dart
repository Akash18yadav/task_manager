import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/app/widget/task_card.dart';
import 'package:task_manager/controller/task_controller.dart';

import '../../../core/enums/view_state.dart';


class TaskListScreen
    extends StatefulWidget {
  const TaskListScreen({
    super.key,
  });

  @override
  State<TaskListScreen> createState() {
    return _TaskListScreenState();
  }
}

class _TaskListScreenState
    extends State<TaskListScreen> {
  final taskController =
      Get.find<TaskController>();

  late final String projectId;

  @override
  void initState() {
    super.initState();

    projectId = Get.arguments as String;

    Future.microtask(() {
      taskController.clearFilters();

      taskController.loadTasks(projectId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),

        actions: [
          IconButton(
            onPressed: _showFilterSheet,
            icon:
                const Icon(Icons.filter_list),
          ),
        ],
      ),

      floatingActionButton:
          FloatingActionButton(
        onPressed: () {
          Get.toNamed(
            '/task-form',
            arguments: {
              'projectId': projectId,
            },
          );
        },
        child: const Icon(Icons.add),
      ),

      body: Obx(() {
        switch (taskController.state.value) {
          case ViewState.initial:
          case ViewState.loading:
            return const Center(
              child:
                  CircularProgressIndicator(),
            );

          case ViewState.empty:
            return _buildEmptyState();

          case ViewState.error:
            return _buildErrorState();

          case ViewState.success:
            final tasks =
                taskController.filteredTasks;

            if (tasks.isEmpty) {
              return const Center(
                child: Text(
                  'No tasks match your filters',
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () =>
                  taskController
                      .refreshTasks(
                projectId,
              ),
              child: ListView.builder(
                physics:
                    const AlwaysScrollableScrollPhysics(),
                itemCount: tasks.length,
                itemBuilder:
                    (context, index) {
                  final task = tasks[index];

                  return TaskCard(
                    task: task,
                    onTap: () {
                      Get.toNamed(
                        '/task-detail',
                        arguments: task.id,
                      );
                    },
                  );
                },
              ),
            );
        }
      }),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          Icon(
            Icons.task_alt,
            size: 70,
          ),
          SizedBox(height: 16),
          Text(
            'No Tasks Found',
            style: TextStyle(
              fontSize: 18,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 70,
            color: Colors.red,
          ),

          const SizedBox(height: 16),

          Padding(
            padding:
                const EdgeInsets.all(20),
            child: Text(
              taskController
                  .errorMessage.value,
              textAlign:
                  TextAlign.center,
            ),
          ),

          ElevatedButton(
            onPressed: () {
              taskController.loadTasks(
                projectId,
              );
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  void _showFilterSheet() {
    Get.bottomSheet(
      Container(
        padding:
            const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Text(
              'Filter Tasks',
              style: TextStyle(
                fontSize: 20,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            const Text('Status'),

            Obx(
              () => DropdownButton<String>(
                value: taskController
                    .selectedStatusFilter
                    .value,
                isExpanded: true,
                items: const [
                  DropdownMenuItem(
                    value: 'all',
                    child: Text('All'),
                  ),
                  DropdownMenuItem(
                    value: 'todo',
                    child: Text('To Do'),
                  ),
                  DropdownMenuItem(
                    value: 'in_progress',
                    child:
                        Text('In Progress'),
                  ),
                  DropdownMenuItem(
                    value: 'completed',
                    child:
                        Text('Completed'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    taskController
                        .changeStatusFilter(
                      value,
                    );
                  }
                },
              ),
            ),

            const SizedBox(height: 20),

            const Text('Priority'),

            Obx(
              () => DropdownButton<String>(
                value: taskController
                    .selectedPriorityFilter
                    .value,
                isExpanded: true,
                items: const [
                  DropdownMenuItem(
                    value: 'all',
                    child: Text('All'),
                  ),
                  DropdownMenuItem(
                    value: 'high',
                    child: Text('High'),
                  ),
                  DropdownMenuItem(
                    value: 'medium',
                    child: Text('Medium'),
                  ),
                  DropdownMenuItem(
                    value: 'low',
                    child: Text('Low'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    taskController
                        .changePriorityFilter(
                      value,
                    );
                  }
                },
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child:
                    const Text('Apply Filters'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}