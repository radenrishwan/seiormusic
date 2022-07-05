import 'package:flutter/material.dart';
import 'package:seiormusic/models/playlist.dart';
import 'package:seiormusic/repository/impl/playlist_repository_impl.dart';
import 'package:seiormusic/repository/playlist_repository.dart';
import 'package:seiormusic/widgets/error_dialog.dart';

class WidgetProvider extends ChangeNotifier {
  final PlaylistRepository _playlistRepository = PlaylistRepositoryImpl();

  String selectedPlaylistId = ''; // TODO: check if playlist not selected

  Future<List<Playlist>> findAllPlaylist(BuildContext context) async {
    return await _playlistRepository.findAll();
  }

  Future<void> addMusicToPlaylist(BuildContext context, String id, String audioId) async {
    try {
      Playlist playlist = await _playlistRepository.findById(id);

      for (var audio in playlist.audioIds) {
        if (audio == audioId) {
          return;
        }
      }
      playlist.audioIds.add(audioId);

      await _playlistRepository.update(playlist);

      selectedPlaylistId = '';
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) => ErrorDialog(
          message: error.toString(),
        ),
      );
    }
  }
}
