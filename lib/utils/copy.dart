import 'package:seiormusic/models/audio.dart';
import 'package:seiormusic/models/recent_audio.dart';

class CopyUtils {
  static RecentAudio copyFromAudio(Audio audio) {
    return RecentAudio(
      artist: audio.artist,
      duration: audio.duration,
      path: audio.path,
      title: audio.title,
      thumbnail: audio.thumbnail,
      favorite: audio.favorite,
      createdAt: DateTime.now().toIso8601String(),
    );
  }
}
