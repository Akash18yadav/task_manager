import '../../core/utils/json_utils.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String? avatarUrl;
  final DateTime? createdAt;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
    this.createdAt,
  });

  factory UserModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return UserModel(
      id: JsonUtils.getString(json, 'id'),
      name: JsonUtils.getString(json, 'name'),
      email: JsonUtils.getString(json, 'email'),
      avatarUrl: JsonUtils.getNullableString(
        json,
        'avatar_url',
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
      'email': email,
      'avatar_url': avatarUrl,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}