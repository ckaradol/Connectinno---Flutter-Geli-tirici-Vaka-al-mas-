import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final String id;
  final String title;
  final String content;
  final String userId;
  final String createdAt;

  const Note({
    required this.id,
    required this.title,
    required this.content,
    required this.userId,
    required this.createdAt,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      userId: json['user_id'] as String,
      createdAt: json['created_at'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'user_id': userId,
      'created_at': createdAt,
    };
  }

  Note copyWith({
    String? id,
    String? title,
    String? content,
    String? userId,
    String? createdAt,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, title, content, userId, createdAt];

  @override
  String toString() {
    return 'Note(id: $id, title: $title, content: $content, userId: $userId, createdAt: $createdAt)';
  }
}
