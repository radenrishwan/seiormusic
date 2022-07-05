import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:seiormusic/models/audio.dart';
import 'package:seiormusic/repository/impl/recent_audio_repository_impl.dart';
import 'package:seiormusic/repository/recent_audio_repository.dart';
import 'package:seiormusic/utils/copy.dart';
import 'package:seiormusic/utils/duration.dart';

class AudioProvider extends ChangeNotifier {
  final player = AudioPlayer();
  final RecentAudioRepository _recentAudioRepository = RecentAudioRepositoryImpl();

  bool status = false;
  Audio recentAudio = Audio(
    id: '',
    artist: '',
    duration: '',
    path: '',
    title: '',
    thumbnail: '',
    favorite: false,
  );
  Duration recentDurationAudio = const Duration(seconds: 0);

  Future<void> playAudio(Audio audio) async {
    await player.setFilePath(audio.path);
    await player.play();

    _recentAudioRepository.insert(CopyUtils.copyFromAudio(audio));

    recentAudio = audio;
    recentDurationAudio = DurationUtils.durationParse(audio.duration);

    notifyListeners();
  }

  Future<void> pauseAudio() async {
    player.pause();
  }

  Future<void> stopAudio() async {
    player.stop();
  }

  Future<void> resumeAudio() async {
    player.play();
  }

  Future<void> onSeek(Duration duration) async {
    player.seek(duration);
  }

  Stream<Duration?> getDuration() {
    return player.positionStream;
  }
}
