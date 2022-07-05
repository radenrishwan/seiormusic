import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:seiormusic/models/audio.dart';
import 'package:seiormusic/models/recent_audio.dart';
import 'package:seiormusic/repository/audio_repository.dart';
import 'package:seiormusic/repository/impl/audio_repository_impl.dart';
import 'package:seiormusic/repository/impl/recent_audio_repository_impl.dart';
import 'package:seiormusic/repository/recent_audio_repository.dart';

class HomeProvider extends ChangeNotifier {
  final AudioRepository _audioRepository = AudioRepositoryImpl();
  final RecentAudioRepository _recentAudioRepository = RecentAudioRepositoryImpl();

  int index = 0;
  List<Audio> audios = [];

  void changeIndex(int index) {
    this.index = index;
    notifyListeners();
  }

  Future<void> findAllAudio() async {
    audios = await _audioRepository.findAll();
  }

  ValueListenable<Box<RecentAudio>> findAllRecentAudio() {
    return _recentAudioRepository.stream();
  }

  Future<void> deleteAudio(String id) async {
    await _audioRepository.delete(id);

    audios = await _audioRepository.findAll();
    notifyListeners();
  }

  Future<void> changeFavorite(Audio audio) async {
    await _audioRepository.update(
      audio.copyWith(
        favorite: !audio.favorite,
      ),
    );

    findAllAudio();

    notifyListeners();
  }
}
