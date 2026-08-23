// import '../../core/utils/json_utils.dart';

// class ProjectModel {
//   final String id;
//   final String organizationId;
//   final String name;
//   final String? description;
//   final String status;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;

//   const ProjectModel({
//     required this.id,
//     required this.organizationId,
//     required this.name,
//     this.description,
//     required this.status,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory ProjectModel.fromJson(
//     Map<String, dynamic> json,
//   ) {
//     return ProjectModel(
//       id: JsonUtils.getString(json, 'id'),
//       organizationId: JsonUtils.getString(
//         json,
//         'organization_id',
//       ),
//       name: JsonUtils.getString(json, 'name'),
//       description: JsonUtils.getNullableString(
//         json,
//         'description',
//       ),
//       status: JsonUtils.getString(json, 'status'),
//       createdAt: JsonUtils.getDateTime(
//         json,
//         'created_at',
//       ),
//       updatedAt: JsonUtils.getDateTime(
//         json,
//         'updated_at',
//       ),
//     );
//   }

//   ProjectModel copyWith({
//     String? id,
//     String? organizationId,
//     String? name,
//     String? description,
//     String? status,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//   }) {
//     return ProjectModel(
//       id: id ?? this.id,
//       organizationId:
//           organizationId ?? this.organizationId,
//       name: name ?? this.name,
//       description:
//           description ?? this.description,
//       status: status ?? this.status,
//       createdAt: createdAt ?? this.createdAt,
//       updatedAt: updatedAt ?? this.updatedAt,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'organization_id': organizationId,
//       'name': name,
//       'description': description,
//       'status': status,
//       'created_at': createdAt?.toIso8601String(),
//       'updated_at': updatedAt?.toIso8601String(),
//     };
//   }
// }

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
    print('');
    print('========== PROJECT MODEL PARSING ==========');
    print('RAW JSON: $json');

    // Different possible organization ID keys
    final organizationId =
        json['organization_id'] ??
        json['organizationId'] ??
        json['org_id'] ??
        '';

    print('Project ID: ${json['id']}');
    print('Project Name: ${json['name']}');
    print('organization_id from JSON: ${json['organization_id']}');
    print('organizationId from JSON: ${json['organizationId']}');
    print('org_id from JSON: ${json['org_id']}');
    print('FINAL Organization ID: $organizationId');
    print('===========================================');

    return ProjectModel(
      id: json['id']?.toString() ?? '',

      organizationId:
          organizationId.toString(),

      name: json['name']?.toString() ?? '',

      description:
          json['description']?.toString(),

      status:
          json['status']?.toString() ??
              'active',

      createdAt:
          json['created_at'] != null
              ? DateTime.tryParse(
                  json['created_at'].toString(),
                )
              : null,

      updatedAt:
          json['updated_at'] != null
              ? DateTime.tryParse(
                  json['updated_at'].toString(),
                )
              : null,
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
          organizationId ??
              this.organizationId,

      name: name ?? this.name,

      description:
          description ??
              this.description,

      status: status ?? this.status,

      createdAt:
          createdAt ??
              this.createdAt,

      updatedAt:
          updatedAt ??
              this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'organization_id': organizationId,
      'name': name,
      'description': description,
      'status': status,
      'created_at':
          createdAt?.toIso8601String(),
      'updated_at':
          updatedAt?.toIso8601String(),
    };
  }
}