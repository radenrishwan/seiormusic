import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:provider/provider.dart';
import 'package:seiormusic/models/audio.dart';
import 'package:seiormusic/utils/color.dart';
import 'package:seiormusic/utils/duration.dart';
import 'package:seiormusic/widgets/dialog.dart';
import 'package:seiormusic/widgets/error_dialog.dart';
import 'package:seiormusic/widgets/provider/widget_provider.dart';

class AudioList extends StatelessWidget {
  final Audio audio;
  final VoidCallback onTap;
  final VoidCallback? onFavoriteTap;
  final VoidCallback? onDeleteTap;
  final int index;

  const AudioList({
    super.key,
    required this.audio,
    required this.onTap,
    required this.index,
    required this.onFavoriteTap,
    required this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    final durationParse = DurationUtils.durationParse(audio.duration);

    return Material(
      child: InkWell(
        onTap: onTap,
        child: fluent.Container(
          color: ColorUtil.background,
          child: fluent.Row(
            children: [
              fluent.Text(
                index.toString(),
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const fluent.SizedBox(
                width: 12,
              ),
              Expanded(
                flex: 4,
                child: fluent.Text(
                  audio.title,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const Spacer(flex: 1),
              Text(
                (durationParse.inMinutes < 10)
                    ? '0${durationParse.inMinutes}:${durationParse.inSeconds % 60}'
                    : '0${durationParse.inMinutes}:${durationParse.inSeconds % 60}',
              ),
              const fluent.SizedBox(width: 12),
              fluent.IconButton(
                onPressed: onFavoriteTap,
                icon: (audio.favorite == true)
                    ? const Icon(
                        Icons.favorite,
                        size: 20,
                      )
                    : const Icon(
                        Icons.favorite_border,
                        size: 20,
                      ),
              ),
              IconButton(
                onPressed: () async {
                  final playlist = await context.read<WidgetProvider>().findAllPlaylist(context);

                  showDialog(
                    context: context,
                    builder: (context) {
                      return CustomDialog(
                        childern: [
                          CustomListTile(
                            leading: const Icon(Icons.playlist_add),
                            onTap: () {},
                            title: const Text('Add to playlist'),
                            subDialog: (playlist.isEmpty)
                                ? const ErrorDialog(message: 'No playlist found, please create one')
                                : fluent.ContentDialog(
                                    title: Text(
                                      'Add to playlist',
                                      style: TextStyle(
                                        fontSize: Theme.of(context).textTheme.headline6!.fontSize ?? 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    content: SizedBox(
                                      width: double.infinity,
                                      child: fluent.DropDownButton(
                                        leading: Icon(
                                          Icons.playlist_add,
                                          color: ColorUtil.primary,
                                        ),
                                        title: const Text('Select playlist'),
                                        items: List.generate(
                                          playlist.length,
                                          (index) {
                                            return fluent.MenuFlyoutItem(
                                              text: Text(playlist[index].name),
                                              onPressed: () {
                                                context.read<WidgetProvider>().selectedPlaylistId =
                                                    playlist[index].id ?? '';
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      fluent.Button(
                                        onPressed: () => Navigator.of(context).pop(),
                                        child: const Text('Cancel'),
                                      ),
                                      fluent.Button(
                                        onPressed: () async {
                                          context.read<WidgetProvider>().addMusicToPlaylist(
                                                context,
                                                context.read<WidgetProvider>().selectedPlaylistId,
                                                audio.id ?? '',
                                              );
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                          ),
                          CustomListTile(
                            leading: const Icon(Icons.delete_outline),
                            onTap: () {},
                            title: const Text('Delete'),
                            subDialog: fluent.ContentDialog(
                              title: Text(
                                'Delete Song',
                                style: TextStyle(
                                  fontSize: Theme.of(context).textTheme.headline6!.fontSize ?? 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              content: const Text('Are you sure you want to delete this audio?'),
                              actions: [
                                fluent.Button(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('Cancel'),
                                ),
                                fluent.Button(
                                  onPressed: onDeleteTap,
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
                      );
                    },
                  );
                },
                icon: const Icon(Icons.more_vert),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
