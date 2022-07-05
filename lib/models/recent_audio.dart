import 'package:hive_flutter/hive_flutter.dart';

part 'recent_audio.g.dart';

@HiveType(typeId: 3)
class RecentAudio {
  @HiveField(0)
  String? id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String path;

  @HiveField(3)
  final String artist;

  @HiveField(4)
  final String duration;

  @HiveField(5)
  final String thumbnail;

  @HiveField(6)
  final bool favorite;

  @HiveField(7)
  final String createdAt;

  RecentAudio({
    this.id,
    required this.artist,
    required this.duration,
    required this.path,
    required this.title,
    required this.thumbnail,
    required this.favorite,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'path': path,
        'artist': artist,
        'duration': duration,
        'thumbnail': thumbnail,
        'favorite': favorite,
        'created_at': createdAt,
      };

  factory RecentAudio.fromJson(Map<String, dynamic> json) => RecentAudio(
        id: json['id'],
        title: json['title'],
        path: json['path'],
        artist: json['artist'],
        duration: json['duration'],
        thumbnail: json['thumbnail'],
        favorite: json['favorite'],
        createdAt: json['created_at'],
      );

  RecentAudio copyWith({
    String? id,
    String? title,
    String? path,
    String? artist,
    String? duration,
    String? thumbnail,
    bool? favorite,
  }) {
    return RecentAudio(
      id: id ?? this.id,
      title: title ?? this.title,
      path: path ?? this.path,
      artist: artist ?? this.artist,
      duration: duration ?? this.duration,
      thumbnail: thumbnail ?? this.thumbnail,
      favorite: favorite ?? this.favorite,
      createdAt: createdAt,
    );
  }
}
