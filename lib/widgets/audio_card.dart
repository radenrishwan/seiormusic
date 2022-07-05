import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:provider/provider.dart';
import 'package:seiormusic/models/audio.dart';
import 'package:seiormusic/modules/audio/providers/audio_provider.dart';
import 'package:seiormusic/utils/color.dart';

class AudioCard extends StatelessWidget {
  final Audio audio;
  const AudioCard({Key? key, required this.audio}) : super(key: key);

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
        onTap: () {
          context.read<AudioProvider>().playAudio(audio);
        },
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
                  child: Image.asset(
                    (audio.thumbnail == '') // TODO: check if url is valid
                        ? 'assets/icons/playlist.png'
                        : audio.thumbnail,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const fluent.SizedBox(height: 6),
              fluent.Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: fluent.Text(
                  audio.title,
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(fontWeight: FontWeight.bold),
                  overflow: fluent.TextOverflow.ellipsis,
                ),
              ),
              const fluent.SizedBox(height: 6),
              fluent.Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: fluent.Text(
                  (audio.artist == '') ? 'Unknown' : audio.artist,
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
