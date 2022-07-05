import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:seiormusic/models/audio.dart';
import 'package:seiormusic/models/playlist.dart';
import 'package:seiormusic/repository/audio_repository.dart';
import 'package:seiormusic/repository/impl/audio_repository_impl.dart';
import 'package:seiormusic/repository/impl/playlist_repository_impl.dart';
import 'package:seiormusic/repository/playlist_repository.dart';
import 'package:seiormusic/widgets/dialog.dart';

class PlaylistProvider extends ChangeNotifier {
  final PlaylistRepository _playlistRepository = PlaylistRepositoryImpl();
  final AudioRepository _audioRepository = AudioRepositoryImpl();

  List<Playlist> playlists = [];
  List<Audio> audios = [];
  List<Playlist> favoritePlaylists = [];

  void createPlaylist(BuildContext context) {
    TextEditingController nameController = TextEditingController();

    fluent.showDialog(
      context: context,
      builder: (context) => CustomDialog(
        childern: [
          CustomListTile(
            leading: const Icon(Icons.playlist_add),
            onTap: () {},
            title: const Text('New playlist'),
            subDialog: fluent.ContentDialog(
              title: Text(
                'New playlist',
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.headline6!.fontSize ?? 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: fluent.TextBox(
                controller: nameController,
                autofocus: true,
                placeholder: 'Enter playlist name',
              ),
              actions: [
                fluent.Button(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                fluent.Button(
                  onPressed: () async {
                    if (nameController.text.length < 3) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return fluent.ContentDialog(
                            title: const Text('Error occured'),
                            content: const Text('Name must be at least 3 characters'),
                            actions: [
                              fluent.Button(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      // get user env
                      final env = Platform.environment;

                      await _playlistRepository
                          .insert(Playlist(
                        name: nameController.text,
                        createdAt: DateTime.now().toIso8601String(),
                        thumbnail: '',
                        audioIds: [],
                        author: env['USER'] ?? 'Unknown',
                        favorite: false,
                      ))
                          .then(
                        (value) {
                          findAllPlaylist();
                          notifyListeners();

                          Navigator.of(context).pop();
                        },
                      );
                    }
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          ),
          CustomListTile(
            leading: const Icon(Icons.cancel_outlined),
            onTap: () {},
            title: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Future<void> findAllPlaylist() async {
    playlists = await _playlistRepository.findAll();
  }

  Future<void> findAllFavoritePlaylist() async {
    final dummy = await _playlistRepository.findAll();

    favoritePlaylists = dummy.where((element) => element.favorite == true).toList();
  }

  Future<void> findAllAudio(List<String> ids) async {
    final audioFind = await _audioRepository.findAll();
    final List<Audio> audioResult = [];

    for (var id in ids) {
      final audio = audioFind.where((audio) => audio.id == id).first;

      audioResult.add(audio);
    }

    audios = audioResult;
  }

  Future<void> changePlaylistFavorite(Playlist playlist) async {
    await _playlistRepository.update(playlist.copyWith(favorite: !playlist.favorite));

    findAllPlaylist();
    findAllFavoritePlaylist();

    notifyListeners();
  }

  Future<void> changeAudioFavorite(Audio audio, List<String> ids) async {
    await _audioRepository.update(
      audio.copyWith(
        favorite: !audio.favorite,
      ),
    );

    findAllAudio(ids);

    notifyListeners();
  }

  void deletePlaylist(String id) {
    _playlistRepository.delete(id);

    findAllFavoritePlaylist();
    findAllPlaylist();

    notifyListeners();
  }
}
