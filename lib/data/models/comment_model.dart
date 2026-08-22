import '../../core/utils/json_utils.dart';

class CommentModel {
  final String id;
  final String taskId;
  final String userId;
  final String content;
  final DateTime? createdAt;

  const CommentModel({
    required this.id,
    required this.taskId,
    required this.userId,
    required this.content,
    this.createdAt,
  });

  factory CommentModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return CommentModel(
      id: JsonUtils.getString(json, 'id'),
      taskId: JsonUtils.getString(
        json,
        'task_id',
      ),
      userId: JsonUtils.getString(
        json,
        'user_id',
      ),
      content: JsonUtils.getString(
        json,
        'content',
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
      'task_id': taskId,
      'user_id': userId,
      'content': content,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}