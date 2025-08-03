import 'package:equatable/equatable.dart';

class Announcement extends Equatable {
  final String id;
  final String title;
  final String content;
  final DateTime date;
  final String type;
  final bool isImportant;

  const Announcement({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.type,
    this.isImportant = false,
  });

  @override
  List<Object?> get props => [id, title, content, date, type, isImportant];

  Announcement copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? date,
    String? type,
    bool? isImportant,
  }) {
    return Announcement(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      date: date ?? this.date,
      type: type ?? this.type,
      isImportant: isImportant ?? this.isImportant,
    );
  }
}
