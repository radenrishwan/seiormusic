import 'package:seiormusic/models/playlist.dart';

abstract class PlaylistRepository {
  Future<List<Playlist>> findAll();
  Future<Playlist> findById(String id);
  Future<Playlist> insert(Playlist playlist);
  Future<Playlist> update(Playlist playlist);
  Future<void> delete(String id);
}
