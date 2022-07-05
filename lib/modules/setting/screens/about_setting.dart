import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;

class AboutSetting extends StatelessWidget {
  const AboutSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {},
      child: const fluent.ListTile(
        leading: Icon(Icons.info_outlined),
        title: Text('About'),
        trailing: Text('About Me'),
      ),
    );
  }
}
