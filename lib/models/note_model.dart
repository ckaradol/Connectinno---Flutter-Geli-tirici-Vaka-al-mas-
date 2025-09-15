import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final String? id;
  final String title;
  final String content;
  final String? userId;
  final DateTime? createdAt;

  const Note({
     this.id,
    required this.title,
    required this.content,
     this.userId,
     this.createdAt,
  });

  factory Note.fromJson(Map<dynamic, dynamic> json) {
    return Note(
      id: json['id'] ,
      title: json['title'] as String,
      content: json['content'] as String,
      userId: json['user_id'] ,
      createdAt: json['created_at'] ==null?null:DateTime.tryParse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'user_id': userId,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  Note copyWith({
    String? id,
    String? title,
    String? content,
    String? userId,
    DateTime? createdAt,
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
  List<Object?> get props => [id];


}
