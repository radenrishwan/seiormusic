import 'package:hive_flutter/hive_flutter.dart';

part 'playlist.g.dart';

@HiveType(typeId: 2)
class Playlist {
  @HiveField(0)
  String? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String createdAt;

  @HiveField(3)
  final String thumbnail;

  @HiveField(4)
  final String author;

  @HiveField(5)
  final List<String> audioIds;

  @HiveField(6)
  final bool favorite;

  Playlist({
    this.id,
    required this.name,
    required this.createdAt,
    required this.thumbnail,
    required this.author,
    required this.audioIds,
    required this.favorite,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'created_at': createdAt,
        'thumbnail': thumbnail,
        'author': author,
        'audioIds': audioIds,
        'favorite': favorite,
      };

  // from json
  factory Playlist.fromJson(Map<String, dynamic> json) => Playlist(
        id: json['id'],
        name: json['name'],
        audioIds: json['audioIds'].cast<String>(),
        createdAt: json['created_at'],
        author: json['author'],
        thumbnail: json['thumbnail'],
        favorite: json['favorite'],
      );

  // copy with
  Playlist copyWith({
    String? id,
    String? name,
    String? createdAt,
    String? thumbnail,
    String? author,
    List<String>? audioIds,
    bool? favorite,
  }) {
    return Playlist(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      thumbnail: thumbnail ?? this.thumbnail,
      author: author ?? this.author,
      audioIds: audioIds ?? this.audioIds,
      favorite: favorite ?? this.favorite,
    );
  }
}
