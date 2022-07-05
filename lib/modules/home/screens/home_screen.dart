import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:seiormusic/models/audio.dart';
import 'package:seiormusic/models/recent_audio.dart';
import 'package:seiormusic/modules/audio/providers/audio_provider.dart';
import 'package:seiormusic/modules/home/providers/home_provider.dart';
import 'package:seiormusic/widgets/audio_card.dart';
import 'package:seiormusic/widgets/audio_list.dart';
import 'package:seiormusic/widgets/empty_widget.dart';
import 'package:seiormusic/widgets/loading_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                  'Recent Audio',
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
            fluent.ValueListenableBuilder<Box<RecentAudio>>(
              valueListenable: context.read<HomeProvider>().findAllRecentAudio(),
              builder: (context, value, child) {
                final data = value.values.toList();

                return (data.isEmpty)
                    ? const EmptyWidget(title: 'Empty Song, go play audio')
                    : SizedBox(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return AudioCard(
                              audio: Audio(
                                id: data[index].id,
                                artist: data[index].artist,
                                duration: data[index].duration,
                                path: data[index].path,
                                title: data[index].title,
                                thumbnail: data[index].thumbnail,
                                favorite: false,
                              ),
                            );
                          },
                        ),
                      );
              },
            ),
            const SizedBox(height: 10),
            fluent.Row(
              children: [
                Text(
                  style: Theme.of(context).textTheme.titleLarge,
                  'Songs',
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
              future: context.read<HomeProvider>().findAllAudio(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == fluent.ConnectionState.waiting) {
                  return const LoadingWidget();
                }

                return Consumer<HomeProvider>(
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
                                    context.read<HomeProvider>().changeFavorite(audio);
                                  },
                                  onDeleteTap: () {
                                    context.read<HomeProvider>().deleteAudio(audio.id ?? '');
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
