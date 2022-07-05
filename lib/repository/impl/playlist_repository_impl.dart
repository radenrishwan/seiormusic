import 'package:hive_flutter/hive_flutter.dart';
import 'package:seiormusic/exception/not_found_exception.dart';
import 'package:seiormusic/models/playlist.dart';
import 'package:seiormusic/repository/playlist_repository.dart';
import 'package:uuid/uuid.dart';

class PlaylistRepositoryImpl implements PlaylistRepository {
  late Box<Playlist> _box;

  static final PlaylistRepositoryImpl _instance = PlaylistRepositoryImpl._internal();

  factory PlaylistRepositoryImpl() => _instance;

  static String boxName = 'playlist';

  PlaylistRepositoryImpl._internal() {
    _box = Hive.box<Playlist>(PlaylistRepositoryImpl.boxName);
  }

  @override
  Future<void> delete(String id) {
    return _box.delete(id);
  }

  @override
  Future<List<Playlist>> findAll() async {
    return _box.values.toList();
  }

  @override
  Future<Playlist> findById(String id) async {
    final playlist = _box.get(id);

    if (playlist == null) {
      throw NotFoundException('Playlist not found');
    }

    return playlist;
  }

  @override
  Future<Playlist> insert(Playlist playlist) async {
    String id = const Uuid().v4();

    playlist.id = id;
    _box.put(id, playlist);

    return playlist;
  }

  @override
  Future<Playlist> update(Playlist playlist) async {
    _box.put(playlist.id, playlist);

    return playlist;
  }
}
