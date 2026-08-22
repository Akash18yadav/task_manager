import '../../core/utils/json_utils.dart';

class TaskModel {
  final String id;
  final String projectId;
  final String title;
  final String? description;
  final String status;
  final String priority;
  final String? assigneeId;
  final DateTime? dueDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const TaskModel({
    required this.id,
    required this.projectId,
    required this.title,
    this.description,
    required this.status,
    required this.priority,
    this.assigneeId,
    this.dueDate,
    this.createdAt,
    this.updatedAt,
  });

  factory TaskModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return TaskModel(
      id: JsonUtils.getString(json, 'id'),
      projectId: JsonUtils.getString(
        json,
        'project_id',
      ),
      title: JsonUtils.getString(json, 'title'),
      description: JsonUtils.getNullableString(
        json,
        'description',
      ),
      status: JsonUtils.getString(
        json,
        'status',
      ),
      priority: JsonUtils.getString(
        json,
        'priority',
      ),
      assigneeId: JsonUtils.getNullableString(
        json,
        'assignee_id',
      ),
      dueDate: JsonUtils.getDateTime(
        json,
        'due_date',
      ),
      createdAt: JsonUtils.getDateTime(
        json,
        'created_at',
      ),
      updatedAt: JsonUtils.getDateTime(
        json,
        'updated_at',
      ),
    );
  }

  TaskModel copyWith({
    String? id,
    String? projectId,
    String? title,
    String? description,
    String? status,
    String? priority,
    String? assigneeId,
    DateTime? dueDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TaskModel(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      title: title ?? this.title,
      description:
          description ?? this.description,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      assigneeId: assigneeId ?? this.assigneeId,
      dueDate: dueDate ?? this.dueDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'project_id': projectId,
      'title': title,
      'description': description,
      'status': status,
      'priority': priority,
      'assignee_id': assigneeId,
      'due_date': dueDate?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}