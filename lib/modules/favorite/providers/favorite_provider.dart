import 'package:flutter/cupertino.dart';
import 'package:seiormusic/models/audio.dart';
import 'package:seiormusic/repository/audio_repository.dart';
import 'package:seiormusic/repository/impl/audio_repository_impl.dart';

class FavoriteProvider extends ChangeNotifier {
  final AudioRepository _audioRepository = AudioRepositoryImpl();

  List<Audio> audios = [];

  Future<void> findAllAudio() async {
    final dummy = await _audioRepository.findAll();

    audios = dummy.where((audio) => audio.favorite == true).toList();
  }

  Future<void> deleteAudio(String id) async {
    await _audioRepository.delete(id);

    audios = await _audioRepository.findAll();
    notifyListeners();
  }

  Future<void> changeAudioFavorite(Audio audio) async {
    await _audioRepository.update(
      audio.copyWith(
        favorite: !audio.favorite,
      ),
    );

    findAllAudio();

    notifyListeners();
  }
}
