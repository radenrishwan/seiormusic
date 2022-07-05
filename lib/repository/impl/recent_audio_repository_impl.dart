import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:seiormusic/exception/not_found_exception.dart';
import 'package:seiormusic/models/recent_audio.dart';
import 'package:seiormusic/repository/recent_audio_repository.dart';
import 'package:uuid/uuid.dart';

class RecentAudioRepositoryImpl implements RecentAudioRepository {
  late Box<RecentAudio> _box;

  static final RecentAudioRepositoryImpl _instance = RecentAudioRepositoryImpl._internal();

  factory RecentAudioRepositoryImpl() => _instance;

  static String boxName = 'recent_audio';

  RecentAudioRepositoryImpl._internal() {
    _box = Hive.box<RecentAudio>(RecentAudioRepositoryImpl.boxName);
  }

  @override
  Future<void> delete(String id) async {
    await _box.delete(id);
  }

  @override
  Future<List<RecentAudio>> findAll() async {
    final result = _box.values.toList();

    result.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return result;
  }

  @override
  Future<RecentAudio> findById(String id) async {
    final audio = _box.get(id);

    if (audio == null) {
      throw NotFoundException('Audio not found');
    }

    return audio;
  }

  @override
  Future<RecentAudio> insert(RecentAudio audio) async {
    String id = const Uuid().v4();

    // check if audio already exists
    final existingAudio = await findAll();

    for (var recentAudio in existingAudio) {
      if (recentAudio.title == audio.title) {
        delete(recentAudio.id ?? '');
      }
    }

    if (existingAudio.length >= 10) {
      await delete(existingAudio.last.id ?? '');
    }

    audio.id = id;
    _box.put(id, audio);

    return audio;
  }

  @override
  Future<RecentAudio> update(RecentAudio audio) async {
    _box.put(audio.id, audio);

    return audio;
  }

  @override
  ValueListenable<Box<RecentAudio>> stream() {
    return _box.listenable();
  }
}
