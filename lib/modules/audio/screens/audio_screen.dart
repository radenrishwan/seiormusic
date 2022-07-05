import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart' as audio_progress;
import 'package:provider/provider.dart';
import 'package:seiormusic/modules/audio/providers/audio_provider.dart';
import 'package:seiormusic/utils/color.dart';

class AudioScreen extends StatefulWidget {
  const AudioScreen({super.key});

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return fluent.PhysicalModel(
      color: Colors.black,
      elevation: 8,
      child: fluent.Container(
        color: Colors.white,
        padding: const fluent.EdgeInsets.symmetric(
          horizontal: 50,
        ),
        height: 100,
        width: fluent.MediaQuery.of(context).size.width,
        child: fluent.Column(
          mainAxisAlignment: fluent.MainAxisAlignment.center,
          crossAxisAlignment: fluent.CrossAxisAlignment.center,
          children: [
            Flexible(
              child: fluent.Text(
                context.watch<AudioProvider>().recentAudio.title,
                overflow: TextOverflow.ellipsis,
                style: const fluent.TextStyle(
                  fontSize: 15,
                  fontWeight: fluent.FontWeight.bold,
                ),
              ),
            ),
            const fluent.SizedBox(height: 8),
            StreamBuilder<Duration?>(
              stream: context.watch<AudioProvider>().getDuration(),
              builder: (context, snapshot) {
                return audio_progress.ProgressBar(
                  progress: snapshot.data ?? Duration.zero,
                  total: context.watch<AudioProvider>().recentDurationAudio,
                  onSeek: (duration) {
                    context.read<AudioProvider>().onSeek(duration);
                  },
                  barHeight: 3,
                  thumbRadius: 5,
                  timeLabelTextStyle: Theme.of(context).textTheme.caption,
                  progressBarColor: ColorUtil.primary,
                  baseBarColor: Colors.black12,
                  thumbColor: ColorUtil.primary,
                );
              },
            ),
            const fluent.SizedBox(height: 8),
            fluent.Row(
              mainAxisAlignment: fluent.MainAxisAlignment.center,
              children: [
                const fluent.Icon(
                  Icons.favorite_outline,
                  size: 25,
                ),
                Container(width: 25),
                const fluent.Spacer(),
                const fluent.Icon(
                  Icons.skip_previous,
                  size: 25,
                ),
                Material(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () async {
                      if (Provider.of<AudioProvider>(context, listen: false).status == true) {
                        Provider.of<AudioProvider>(context, listen: false).status = false;
                        animationController.forward();
                      } else {
                        Provider.of<AudioProvider>(context, listen: false).status = true;
                        animationController.reverse();
                      }
                    },
                    child: AnimatedIcon(
                      size: 25,
                      icon: AnimatedIcons.play_pause,
                      progress: animationController,
                    ),
                  ),
                ),
                const fluent.Icon(
                  Icons.skip_next,
                  size: 25,
                ),
                const fluent.Spacer(),
                const fluent.Icon(
                  Icons.repeat,
                  size: 25,
                ),
                const fluent.Icon(
                  Icons.shuffle,
                  size: 25,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
