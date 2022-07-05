import 'package:seiormusic/models/audio.dart';

abstract class AudioRepository {
  Future<List<Audio>> findAll();
  Future<Audio> findById(String id);
  Future<Audio> insert(Audio audio);
  Future<Audio> update(Audio audio);
  Future<void> delete(String id);
}
