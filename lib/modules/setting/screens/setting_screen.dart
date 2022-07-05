import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:seiormusic/modules/setting/screens/about_setting.dart';
import 'package:seiormusic/modules/setting/screens/color_setting.dart';
import 'package:seiormusic/modules/setting/screens/import_music_setting.dart';
import 'package:seiormusic/modules/setting/screens/language_setting.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: fluent.kDefaultContentPadding,
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false, dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          }),
          child: ListView(
            children: [
              fluent.Text(
                'Settings',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              const ImportMusicSetting(),
              const LanguageSetting(),
              const ColorSetting(),
              const AboutSetting(),
              const SizedBox(height: 100)
            ],
          ),
        ),
      ),
    );
  }
}
