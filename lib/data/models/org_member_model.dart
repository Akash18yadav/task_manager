import '../../core/utils/json_utils.dart';

class OrgMemberModel {
  final String id;
  final String organizationId;
  final String userId;
  final String role;
  final DateTime? joinedAt;

  const OrgMemberModel({
    required this.id,
    required this.organizationId,
    required this.userId,
    required this.role,
    this.joinedAt,
  });

  bool get isAdmin => role == 'org_admin';

  factory OrgMemberModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return OrgMemberModel(
      id: JsonUtils.getString(json, 'id'),
      organizationId: JsonUtils.getString(
        json,
        'organization_id',
      ),
      userId: JsonUtils.getString(
        json,
        'user_id',
      ),
      role: JsonUtils.getString(
        json,
        'role',
      ),
      joinedAt: JsonUtils.getDateTime(
        json,
        'joined_at',
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'organization_id': organizationId,
      'user_id': userId,
      'role': role,
      'joined_at': joinedAt?.toIso8601String(),
    };
  }
}