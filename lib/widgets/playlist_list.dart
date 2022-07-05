import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:seiormusic/models/playlist.dart';
import 'package:seiormusic/utils/route.dart';
import 'package:seiormusic/widgets/dialog.dart';

class PlaylistList extends StatelessWidget {
  final Playlist playlist;
  final VoidCallback onFavoriteTap;
  final VoidCallback onDeleteTap;

  const PlaylistList({
    super.key,
    required this.playlist,
    required this.onFavoriteTap,
    required this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          RouteUtil.playlistDetail,
          arguments: playlist,
        );
      },
      child: fluent.Row(
        children: [
          // TODO : check if thumbnail is null
          Image.asset(
            'assets/icons/playlist.png',
            height: 50,
            width: 50,
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
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        fontWeight: fluent.FontWeight.bold,
                      ),
                ),
                fluent.Text(playlist.author),
              ],
            ),
          ),
          const fluent.Spacer(),
          fluent.IconButton(
            onPressed: onFavoriteTap,
            icon: fluent.Icon((playlist.favorite) ? Icons.favorite : Icons.favorite_outline, size: 25),
          ),
          fluent.IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return CustomDialog(
                    childern: [
                      CustomListTile(
                        leading: const Icon(Icons.delete_outline),
                        onTap: () {},
                        title: const Text('Delete'),
                        subDialog: fluent.ContentDialog(
                          title: Text(
                            'Delete Playlist',
                            style: TextStyle(
                              fontSize: Theme.of(context).textTheme.headline6!.fontSize ?? 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          content: const Text('Are you sure you want to delete this playlist ?'),
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
            icon: const fluent.Icon(Icons.more_vert, size: 25),
          ),
        ],
      ),
    );
  }
}
