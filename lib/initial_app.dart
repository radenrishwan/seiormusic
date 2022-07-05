import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:seiormusic/modules/audio/screens/audio_screen.dart';
import 'package:seiormusic/modules/favorite/screens/favorite_screen.dart';
import 'package:seiormusic/modules/home/screens/home_screen.dart';
import 'package:seiormusic/modules/playlist/screens/playlist_screen.dart';
import 'package:seiormusic/modules/setting/screens/setting_screen.dart';

class InitialApp extends StatefulWidget {
  const InitialApp({Key? key}) : super(key: key);

  @override
  State<InitialApp> createState() => _InitialAppState();
}

class _InitialAppState extends State<InitialApp> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        fluent.NavigationView(
          // appBar: const NavigationAppBar(
          //   title: Text("Seior Music"),
          // ),
          pane: fluent.NavigationPane(
            selected: _index,
            onChanged: (index) {
              setState(() {
                _index = index;
              });
            },
            header: Container(
              height: fluent.kOneLineTileHeight,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const FlutterLogo(),
                  const SizedBox(width: 10),
                  Text(
                    'Seior Music',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            displayMode: fluent.PaneDisplayMode.compact,
            items: [
              fluent.PaneItem(
                icon: const Icon(fluent.FluentIcons.home),
                title: const Text('Home'),
              ),
              fluent.PaneItem(
                icon: const Icon(fluent.FluentIcons.playlist_music),
                title: const Text('Playlist'),
              ),
              fluent.PaneItem(
                icon: const Icon(fluent.FluentIcons.favorite_star),
                title: const Text('Favorites'),
              ),
              fluent.PaneItem(
                icon: const Icon(fluent.FluentIcons.settings),
                title: const Text('Settings'),
              ),
            ],
          ),
          content: fluent.NavigationBody(
            index: _index,
            children: const [
              HomeScreen(),
              PlaylistScreen(),
              FavoriteScreen(),
              SettingScreen(),
            ],
          ),
        ),
        const fluent.Positioned(
          bottom: 0,
          child: AudioScreen(),
        )
      ],
    );
  }
}
