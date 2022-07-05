import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seiormusic/models/audio.dart';
import 'package:seiormusic/modules/audio/providers/audio_provider.dart';
import 'package:seiormusic/modules/favorite/providers/favorite_provider.dart';
import 'package:seiormusic/widgets/audio_list.dart';
import 'package:seiormusic/widgets/empty_widget.dart';
import 'package:seiormusic/widgets/loading_widget.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: fluent.kDefaultContentPadding,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false, dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        }),
        child: ListView(
          children: [
            fluent.Row(
              children: [
                Text(
                  style: Theme.of(context).textTheme.titleLarge,
                  'Favorite Songs',
                ),
                const fluent.Spacer(),
                const Icon(
                  Icons.more_horiz,
                  size: 25,
                ),
              ],
            ),
            const SizedBox(height: 10),
            fluent.FutureBuilder<void>(
              future: context.read<FavoriteProvider>().findAllAudio(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == fluent.ConnectionState.waiting) {
                  return const LoadingWidget();
                }

                return Consumer<FavoriteProvider>(
                  builder: (context, value, child) {
                    return fluent.Column(
                      children: (value.audios.isEmpty)
                          ? [
                              const EmptyWidget(title: 'Empty Song, Please Add Some Songs'),
                            ]
                          : List.generate(
                              value.audios.length,
                              (index) {
                                final audio = value.audios[index];

                                return AudioList(
                                  audio: Audio(
                                    id: audio.id ?? '',
                                    artist: audio.artist,
                                    duration: audio.duration,
                                    path: audio.path,
                                    title: audio.title,
                                    thumbnail: audio.thumbnail,
                                    favorite: audio.favorite,
                                  ),
                                  index: index + 1,
                                  onTap: () {
                                    Provider.of<AudioProvider>(context, listen: false).playAudio(audio);
                                  },
                                  onFavoriteTap: () {
                                    context.read<FavoriteProvider>().changeAudioFavorite(audio);
                                  },
                                  onDeleteTap: () {
                                    context.read<FavoriteProvider>().deleteAudio(audio.id ?? '');
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
            const fluent.SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
