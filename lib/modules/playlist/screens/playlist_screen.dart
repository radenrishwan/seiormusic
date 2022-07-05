import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seiormusic/modules/playlist/providers/playlist_provider.dart';
import 'package:seiormusic/utils/color.dart';
import 'package:seiormusic/utils/route.dart';
import 'package:seiormusic/widgets/empty_widget.dart';
import 'package:seiormusic/widgets/loading_widget.dart';
import 'package:seiormusic/widgets/playlist_card.dart';
import 'package:seiormusic/widgets/playlist_list.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: fluent.Container(
        color: ColorUtil.background,
        padding: fluent.kDefaultContentPadding,
        child: fluent.ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false, dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          }),
          child: fluent.ListView(
            children: [
              fluent.Row(
                children: [
                  Text(
                    'Favorit Playlist',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const fluent.Spacer(),
                  const Icon(
                    Icons.more_horiz,
                    size: 25,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // SizedBox(
              //   height: 200,
              //   width: MediaQuery.of(context).size.width,
              //   child: ListView.builder(
              //     scrollDirection: Axis.horizontal,
              //     itemCount: playlists.length,
              //     itemBuilder: (context, index) {
              //       return PlaylistCard(
              //         onTap: () => Navigator.pushNamed(context, RouteUtil.playlistDetail),
              //         playlist: Playlist(
              //           name: playlists[index]['name'].toString(),
              //           author: playlists[index]['author'].toString(),
              //           createdAt: playlists[index]['createdAt'].toString(),
              //           thumbnail: playlists[index]['thumbnail'].toString(),
              //           audioIds: [],
              //         ),
              //       );
              //     },
              //   ),
              // ),
              // TODO : Playlsit here
              fluent.FutureBuilder<void>(
                future: context.read<PlaylistProvider>().findAllFavoritePlaylist(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == fluent.ConnectionState.waiting) {
                    return const LoadingWidget();
                  }

                  return Consumer<PlaylistProvider>(
                    builder: (context, value, child) {
                      if (value.favoritePlaylists.isEmpty) {
                        return const EmptyWidget(title: 'No Favorite Playlist');
                      }

                      return SizedBox(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: value.favoritePlaylists.length,
                          itemBuilder: (context, index) {
                            return PlaylistCard(
                              onTap: () => Navigator.pushNamed(
                                context,
                                RouteUtil.playlistDetail,
                                arguments: value.favoritePlaylists[index],
                              ),
                              playlist: value.favoritePlaylists[index],
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 10),
              fluent.Row(
                children: [
                  Text(
                    'Playlist',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const fluent.Spacer(),
                  InkWell(
                    onTap: () {
                      context.read<PlaylistProvider>().createPlaylist(context);
                    },
                    child: const fluent.Icon(Icons.more_horiz),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              fluent.FutureBuilder(
                future: context.read<PlaylistProvider>().findAllPlaylist(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == fluent.ConnectionState.waiting) {
                    return const LoadingWidget();
                  }

                  return Consumer<PlaylistProvider>(
                    builder: (context, value, child) {
                      return fluent.Column(
                        children: (value.playlists.isEmpty)
                            ? [
                                const EmptyWidget(title: 'Empty Song, Please Add Some Playlists'),
                              ]
                            : List.generate(
                                value.playlists.length,
                                (index) {
                                  final playlist = value.playlists[index];

                                  return PlaylistList(
                                    playlist: playlist,
                                    onFavoriteTap: () {
                                      context.read<PlaylistProvider>().changePlaylistFavorite(playlist);
                                    },
                                    onDeleteTap: () {
                                      context.read<PlaylistProvider>().deletePlaylist(playlist.id ?? '');
                                      Navigator.pop(context);
                                    },
                                  );
                                },
                              ),
                      );
                    },
                  );
                },
              ),
              const fluent.SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
