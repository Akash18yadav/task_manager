import '../../core/utils/json_utils.dart';

class NotificationModel {
  final String id;
  final String userId;
  final String title;
  final String message;
  final bool isRead;
  final DateTime? createdAt;

  const NotificationModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.message,
    required this.isRead,
    this.createdAt,
  });

  factory NotificationModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return NotificationModel(
      id: JsonUtils.getString(json, 'id'),
      userId: JsonUtils.getString(
        json,
        'user_id',
      ),
      title: JsonUtils.getString(
        json,
        'title',
      ),
      message: JsonUtils.getString(
        json,
        'message',
      ),
      isRead: JsonUtils.getBool(
        json,
        'is_read',
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
      'user_id': userId,
      'title': title,
      'message': message,
      'is_read': isRead,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}