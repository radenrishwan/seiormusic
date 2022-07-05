import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:seiormusic/models/audio.dart';
import 'package:seiormusic/models/playlist.dart';
import 'package:seiormusic/models/recent_audio.dart';
import 'package:seiormusic/modules/audio/providers/audio_provider.dart';
import 'package:seiormusic/modules/favorite/providers/favorite_provider.dart';
import 'package:seiormusic/modules/home/providers/home_provider.dart';
import 'package:seiormusic/modules/playlist/providers/playlist_provider.dart';
import 'package:seiormusic/modules/setting/providers/setting_provider.dart';
import 'package:seiormusic/repository/impl/audio_repository_impl.dart';
import 'package:seiormusic/repository/impl/playlist_repository_impl.dart';
import 'package:seiormusic/repository/impl/recent_audio_repository_impl.dart';
import 'package:seiormusic/utils/color.dart';
import 'package:seiormusic/utils/route.dart';
import 'package:seiormusic/widgets/provider/widget_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final path = await getApplicationDocumentsDirectory();
  await Hive.initFlutter('${path.path}/seiormusic');

  // register adapter to Hive
  Hive.registerAdapter(AudioAdapter());
  Hive.registerAdapter(PlaylistAdapter());
  Hive.registerAdapter(RecentAudioAdapter());

  // open all box
  await Hive.openBox<Audio>(AudioRepositoryImpl.boxName);
  await Hive.openBox<Playlist>(PlaylistRepositoryImpl.boxName);
  await Hive.openBox<RecentAudio>(RecentAudioRepositoryImpl.boxName);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => AudioProvider()),
        ChangeNotifierProvider(create: (context) => PlaylistProvider()),
        ChangeNotifierProvider(create: (context) => FavoriteProvider()),
        ChangeNotifierProvider(create: (context) => SettingProvider()),
        ChangeNotifierProvider(create: (context) => WidgetProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends fluent.StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  fluent.State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends fluent.State<MyApp> {
  @override
  void dispose() {
    context.read<AudioPlayer>().stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return fluent.FluentApp(
      title: 'Seior Music',
      theme: fluent.ThemeData(
        scaffoldBackgroundColor: Colors.white,
        brightness: Brightness.light,
        iconTheme: IconThemeData(
          color: ColorUtil.primary,
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: RouteUtil.initial,
      routes: RouteUtil.routes,
    );
  }
}
