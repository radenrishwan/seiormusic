import 'package:hive_flutter/hive_flutter.dart';
import 'package:seiormusic/exception/not_found_exception.dart';
import 'package:seiormusic/models/audio.dart';
import 'package:seiormusic/repository/audio_repository.dart';
import 'package:uuid/uuid.dart';

class AudioRepositoryImpl implements AudioRepository {
  late Box<Audio> _box;

  static final AudioRepositoryImpl _instance = AudioRepositoryImpl._internal();

  factory AudioRepositoryImpl() => _instance;

  static String boxName = 'audio';

  AudioRepositoryImpl._internal() {
    _box = Hive.box<Audio>(AudioRepositoryImpl.boxName);
  }

  @override
  Future<void> delete(String id) async {
    await _box.delete(id);
  }

  @override
  Future<List<Audio>> findAll() async {
    return _box.values.toList();
  }

  @override
  Future<Audio> findById(String id) async {
    final audio = _box.get(id);

    if (audio == null) {
      throw NotFoundException('Audio not found');
    }

    return audio;
  }

  @override
  Future<Audio> insert(Audio audio) async {
    String id = const Uuid().v4();

    audio.id = id;
    _box.put(id, audio);

    return audio;
  }

  @override
  Future<Audio> update(Audio audio) async {
    _box.put(audio.id, audio);

    return audio;
  }
}
