import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:seiormusic/models/playlist.dart';
import 'package:seiormusic/utils/color.dart';
import 'package:seiormusic/utils/route.dart';

class PlaylistCard extends StatelessWidget {
  final Playlist playlist;
  final VoidCallback onTap;

  const PlaylistCard({
    Key? key,
    required this.playlist,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      color: ColorUtil.background,
      shape: const fluent.RoundedRectangleBorder(
        borderRadius: fluent.BorderRadius.all(
          fluent.Radius.circular(12),
        ),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, RouteUtil.playlistDetail, arguments: playlist),
        child: Container(
          height: 180,
          width: 150,
          padding: const fluent.EdgeInsets.only(bottom: 12),
          child: fluent.Column(
            mainAxisAlignment: fluent.MainAxisAlignment.start,
            crossAxisAlignment: fluent.CrossAxisAlignment.start,
            children: [
              Expanded(
                child: fluent.ClipRRect(
                  borderRadius: const fluent.BorderRadius.only(
                    topLeft: fluent.Radius.circular(12),
                    topRight: fluent.Radius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      Image.asset('assets/icons/playlist.png'),
                      const Positioned(
                        right: 0,
                        bottom: 0,
                        child: Icon(
                          Icons.playlist_play,
                          size: 25,
                        ),
                      ),
                      const Positioned(
                        right: 0,
                        bottom: 0,
                        child: Icon(
                          Icons.playlist_play,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const fluent.SizedBox(height: 6),
              fluent.Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: fluent.Text(
                  playlist.name,
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  overflow: fluent.TextOverflow.ellipsis,
                ),
              ),
              const fluent.SizedBox(height: 6),
              fluent.Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: fluent.Text(
                  playlist.author.replaceFirst(playlist.author[0], playlist.author[0].toUpperCase()),
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
