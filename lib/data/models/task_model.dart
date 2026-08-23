

// class TaskModel {
//   final String id;
//   final String projectId;
//   final String organizationId;
//   final String title;
//   final String? description;
//   final String status;
//   final String priority;
//   final String? assigneeId;
//   final DateTime? dueDate;
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   const TaskModel({
//     required this.id,
//     required this.projectId,
//     required this.organizationId,
//     required this.title,
//     this.description,
//     required this.status,
//     required this.priority,
//     this.assigneeId,
//     this.dueDate,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory TaskModel.fromJson(
//     Map<String, dynamic> json,
//   ) {
//     return TaskModel(
//       id: json['id']?.toString() ?? '',
//       projectId: json['project_id']?.toString() ?? '',
//       organizationId:
//           json['organization_id']?.toString() ?? '',
//       title: json['title']?.toString() ?? '',
//       description: json['description']?.toString(),
//       status: json['status']?.toString() ?? 'todo',
//       priority:
//           json['priority']?.toString() ?? 'medium',
//       assigneeId:
//           json['assignee_id']?.toString(),
//       dueDate: json['due_date'] != null
//           ? DateTime.tryParse(
//               json['due_date'].toString(),
//             )
//           : null,
//       createdAt: DateTime.tryParse(
//             json['created_at']?.toString() ?? '',
//           ) ??
//           DateTime.now(),
//       updatedAt: DateTime.tryParse(
//             json['updated_at']?.toString() ?? '',
//           ) ??
//           DateTime.now(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'project_id': projectId,
//       'organization_id': organizationId,
//       'title': title,
//       'description': description,
//       'status': status,
//       'priority': priority,
//       'assignee_id': assigneeId,
//       'due_date': dueDate?.toIso8601String(),
//       'created_at':
//           createdAt.toIso8601String(),
//       'updated_at':
//           updatedAt.toIso8601String(),
//     };
//   }

//   TaskModel copyWith({
//     String? id,
//     String? projectId,
//     String? organizationId,
//     String? title,
//     String? description,
//     String? status,
//     String? priority,
//     String? assigneeId,
//     DateTime? dueDate,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//   }) {
//     return TaskModel(
//       id: id ?? this.id,
//       projectId:
//           projectId ?? this.projectId,
//       organizationId:
//           organizationId ??
//               this.organizationId,
//       title: title ?? this.title,
//       description:
//           description ?? this.description,
//       status: status ?? this.status,
//       priority:
//           priority ?? this.priority,
//       assigneeId:
//           assigneeId ?? this.assigneeId,
//       dueDate: dueDate ?? this.dueDate,
//       createdAt:
//           createdAt ?? this.createdAt,
//       updatedAt:
//           updatedAt ?? this.updatedAt,
//     );
//   }
// }


class TaskModel {
  final String id;
  final String projectId;
  final String organizationId;
  final String title;
  final String? description;
  final String status;
  final String priority;
  final String? assigneeId;
  final DateTime? dueDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TaskModel({
    required this.id,
    required this.projectId,
    required this.organizationId,
    required this.title,
    this.description,
    required this.status,
    required this.priority,
    this.assigneeId,
    this.dueDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TaskModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final createdAt =
        DateTime.tryParse(
              json['created_at']?.toString() ?? '',
            ) ??
            DateTime.now();

    return TaskModel(
      id: json['id']?.toString() ?? '',

      projectId:
          json['project_id']?.toString() ?? '',

      // JSON me organization_id nahi hai
      organizationId:
          json['organization_id']?.toString() ?? '',

      title:
          json['title']?.toString() ?? '',

      description:
          json['description']?.toString(),

      status:
          json['status']?.toString() ?? 'todo',

      priority:
          json['priority']?.toString() ?? 'medium',

      assigneeId:
          json['assignee_id']?.toString(),

      dueDate:
          json['due_date'] != null
              ? DateTime.tryParse(
                  json['due_date'].toString(),
                )
              : null,

      createdAt: createdAt,

      // JSON me updated_at nahi hai
      updatedAt:
          DateTime.tryParse(
            json['updated_at']?.toString() ?? '',
          ) ??
          createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'project_id': projectId,
      'organization_id': organizationId,
      'title': title,
      'description': description,
      'status': status,
      'priority': priority,
      'assignee_id': assigneeId,
      'due_date': dueDate?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  TaskModel copyWith({
    String? id,
    String? projectId,
    String? organizationId,
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

      projectId:
          projectId ?? this.projectId,

      organizationId:
          organizationId ?? this.organizationId,

      title:
          title ?? this.title,

      description:
          description ?? this.description,

      status:
          status ?? this.status,

      priority:
          priority ?? this.priority,

      assigneeId:
          assigneeId ?? this.assigneeId,

      dueDate:
          dueDate ?? this.dueDate,

      createdAt:
          createdAt ?? this.createdAt,

      updatedAt:
          updatedAt ?? this.updatedAt,
    );
  }
}