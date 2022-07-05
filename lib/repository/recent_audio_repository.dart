import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:seiormusic/models/recent_audio.dart';

abstract class RecentAudioRepository {
  Future<List<RecentAudio>> findAll();
  Future<RecentAudio> findById(String id);
  Future<RecentAudio> insert(RecentAudio audio);
  Future<RecentAudio> update(RecentAudio audio);
  Future<void> delete(String id);
  ValueListenable<Box<RecentAudio>> stream();
}
