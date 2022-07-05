import 'package:hive_flutter/hive_flutter.dart';

part 'audio.g.dart';

@HiveType(typeId: 1)
class Audio {
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

  Audio({
    this.id,
    required this.artist,
    required this.duration,
    required this.path,
    required this.title,
    required this.thumbnail,
    required this.favorite,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'path': path,
        'artist': artist,
        'duration': duration,
        'thumbnail': thumbnail,
        'favorite': favorite,
      };

  factory Audio.fromJson(Map<String, dynamic> json) => Audio(
        id: json['id'],
        title: json['title'],
        path: json['path'],
        artist: json['artist'],
        duration: json['duration'],
        thumbnail: json['thumbnail'],
        favorite: json['favorite'],
      );

  @override
  String toString() {
    return 'Audio{title: $title, path: $path, artist: $artist, duration: $duration, thumbnail: $thumbnail, favorite: $favorite}';
  }

  Audio copyWith({
    String? id,
    String? title,
    String? path,
    String? artist,
    String? duration,
    String? thumbnail,
    bool? favorite,
  }) {
    return Audio(
      id: id ?? this.id,
      title: title ?? this.title,
      path: path ?? this.path,
      artist: artist ?? this.artist,
      duration: duration ?? this.duration,
      thumbnail: thumbnail ?? this.thumbnail,
      favorite: favorite ?? this.favorite,
    );
  }
}
