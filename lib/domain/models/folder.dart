import 'package:equatable/equatable.dart';

class Folder extends Equatable {
  final String id;
  final String name;
  final int totalNotes;
  final DateTime createdAt;
  final FolderType type; // now an enum instead of String or int

  const Folder({
    required this.id,
    required this.name,
    required this.totalNotes,
    required this.createdAt,
    this.type = FolderType.other, // default for user-created
  });

  factory Folder.fromMap(Map<String, dynamic> map) => Folder(
    id: map['id'] as String,
    name: map['name'] as String,
    totalNotes: map['note_count'] is int
        ? map['note_count'] as int
        : int.tryParse(map['note_count']?.toString() ?? '0') ?? 0,
    createdAt: DateTime.parse(map['created_at'] as String),
    type: FolderTypeX.fromInt(map['type'] as int? ?? 0), // convert int to enum
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'note_count': totalNotes,
    'created_at': createdAt.toIso8601String(),
    'type': type.toInt(), // send it as an int
  };

  @override
  List<Object?> get props => [id, name, totalNotes, createdAt, type];

  Folder copyWith({
    String? id,
    String? name,
    int? totalNotes,
    DateTime? createdAt,
    FolderType? type,
  }) {
    return Folder(
      id: id ?? this.id,
      name: name ?? this.name,
      totalNotes: totalNotes ?? this.totalNotes,
      createdAt: createdAt ?? this.createdAt,
      type: type ?? this.type,
    );
  }
}

enum FolderType {
  work("Work"),
  personal("Personal"),
  study("Study"),
  ideas("Ideas"),
  other("Other"),
  all("All");

  final String name;

  const FolderType(this.name);
}

extension FolderTypeX on FolderType {
  /// Turn this enum into the integer code you send/receive from your API.
  int toInt() => index;

  /// Turn an int from the API into one of our enum values (defaults to .other).
  static FolderType fromInt(int code) {
    return (code >= 0 && code < FolderType.values.length)
        ? FolderType.values[code]
        : FolderType.other;
  }
}
