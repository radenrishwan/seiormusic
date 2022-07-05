import 'package:seiormusic/initial_app.dart';
import 'package:seiormusic/modules/playlist/screens/playlist_detail_screen.dart';
import 'package:seiormusic/modules/playlist/screens/playlist_screen.dart';

class RouteUtil {
  static final routes = {
    '/': (context) => const InitialApp(),
    '/playlist': (context) => const PlaylistScreen(),
    '/playlist_detail': (context) => const PlaylistDetailScreen(),
  };

  static const initial = '/';
  static const playlist = '/playlist';
  static const playlistDetail = '/playlist_detail';
}
