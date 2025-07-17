import 'package:equatable/equatable.dart';

class Folder extends Equatable {
  final String id;
  final String name;
  final int totalNotes;
  final DateTime createdAt;

  const Folder({
    required this.id,
    required this.name,
    required this.totalNotes,
    required this.createdAt,
  });

  factory Folder.fromMap(Map<String, dynamic> map) => Folder(
    id: map['id'] as String,
    name: map['name'] as String,
    totalNotes: map['note_count'] is int
        ? map['note_count'] as int
        : int.tryParse(map['note_count']?.toString() ?? '0') ?? 0,
    createdAt: DateTime.parse(map['created_at'] as String),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'note_count': totalNotes,
    'created_at': createdAt.toIso8601String(),
  };

  @override
  List<Object?> get props => [id, name, totalNotes, createdAt];

  Folder copyWith({
    String? id,
    String? name,
    int? totalNotes,
    DateTime? createdAt,
  }) {
    return Folder(
      id: id ?? this.id,
      name: name ?? this.name,
      totalNotes: totalNotes ?? this.totalNotes,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
