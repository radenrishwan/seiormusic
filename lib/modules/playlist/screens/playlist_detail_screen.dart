import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seiormusic/models/audio.dart';
import 'package:seiormusic/models/playlist.dart';
import 'package:seiormusic/modules/audio/providers/audio_provider.dart';
import 'package:seiormusic/modules/playlist/providers/playlist_provider.dart';

import 'package:seiormusic/utils/color.dart';
import 'package:seiormusic/widgets/audio_list.dart';
import 'package:seiormusic/widgets/empty_widget.dart';
import 'package:seiormusic/widgets/loading_widget.dart';

class PlaylistDetailScreen extends StatelessWidget {
  const PlaylistDetailScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final playlist = fluent.ModalRoute.of(context)?.settings.arguments as Playlist;

    return fluent.ScaffoldPage(
      padding: const fluent.EdgeInsets.only(top: 12),
      header: fluent.Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: fluent.PageHeader(
          padding: 0,
          leading: fluent.IconButton(
              onPressed: () => Navigator.pop(context), icon: const fluent.Icon(fluent.FluentIcons.back)),
          title: fluent.Padding(
            padding: const EdgeInsets.only(left: fluent.kPageDefaultVerticalPadding),
            child: Text(
              'Playlist',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
      ),
      content: fluent.Container(
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
                  Image.asset(
                    'assets/icons/playlist.png',
                    height: 80,
                    width: 80,
                  ),
                  const fluent.SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: fluent.Column(
                      mainAxisAlignment: fluent.MainAxisAlignment.end,
                      crossAxisAlignment: fluent.CrossAxisAlignment.start,
                      children: [
                        fluent.Text(
                          playlist.name,
                          style: Theme.of(context).textTheme.headline5?.copyWith(
                                fontWeight: fluent.FontWeight.bold,
                              ),
                        ),
                        fluent.Text(
                          playlist.author,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ),
                  const fluent.Spacer(),
                  fluent.IconButton(
                    onPressed: () {},
                    icon: fluent.Icon((playlist.favorite) ? Icons.favorite : Icons.favorite_outline, size: 25),
                  ),
                ],
              ),
              const fluent.SizedBox(
                height: 12,
              ),
              Text(
                'List Songs',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const fluent.SizedBox(
                height: 12,
              ),
              fluent.FutureBuilder<void>(
                future: context.read<PlaylistProvider>().findAllAudio(playlist.audioIds),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == fluent.ConnectionState.waiting) {
                    return const LoadingWidget();
                  }

                  return Consumer<PlaylistProvider>(
                    builder: (context, value, child) {
                      if (value.audios.isEmpty) {
                        return const EmptyWidget(title: 'Empty Song, Please Add Some Songs');
                      }

                      return fluent.Column(
                        children: List.generate(
                          value.audios.length,
                          (index) {
                            final audio = Audio(
                              id: value.audios[index].id,
                              artist: value.audios[index].artist,
                              duration: value.audios[index].duration,
                              path: value.audios[index].path,
                              title: value.audios[index].title,
                              thumbnail: value.audios[index].thumbnail,
                              favorite: value.audios[index].favorite,
                            );

                            return AudioList(
                              audio: audio,
                              index: index + 1,
                              onTap: () {
                                context.read<AudioProvider>().playAudio(value.audios[index]);
                              },
                              onFavoriteTap: () {
                                context.read<PlaylistProvider>().changeAudioFavorite(audio, playlist.audioIds);
                              },
                              onDeleteTap: () {},
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
