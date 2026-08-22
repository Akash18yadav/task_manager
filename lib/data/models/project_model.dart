import '../../core/utils/json_utils.dart';

class ProjectModel {
  final String id;
  final String organizationId;
  final String name;
  final String? description;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ProjectModel({
    required this.id,
    required this.organizationId,
    required this.name,
    this.description,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory ProjectModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ProjectModel(
      id: JsonUtils.getString(json, 'id'),
      organizationId: JsonUtils.getString(
        json,
        'organization_id',
      ),
      name: JsonUtils.getString(json, 'name'),
      description: JsonUtils.getNullableString(
        json,
        'description',
      ),
      status: JsonUtils.getString(json, 'status'),
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

  ProjectModel copyWith({
    String? id,
    String? organizationId,
    String? name,
    String? description,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProjectModel(
      id: id ?? this.id,
      organizationId:
          organizationId ?? this.organizationId,
      name: name ?? this.name,
      description:
          description ?? this.description,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'organization_id': organizationId,
      'name': name,
      'description': description,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}