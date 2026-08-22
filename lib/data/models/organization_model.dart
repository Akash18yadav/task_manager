import '../../core/utils/json_utils.dart';

class OrganizationModel {
  final String id;
  final String name;
  final String? description;
  final DateTime? createdAt;

  const OrganizationModel({
    required this.id,
    required this.name,
    this.description,
    this.createdAt,
  });

  factory OrganizationModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return OrganizationModel(
      id: JsonUtils.getString(json, 'id'),
      name: JsonUtils.getString(json, 'name'),
      description: JsonUtils.getNullableString(
        json,
        'description',
      ),
      createdAt: JsonUtils.getDateTime(
        json,
        'created_at',
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}