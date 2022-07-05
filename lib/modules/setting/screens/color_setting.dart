import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;

class ColorSetting extends StatelessWidget {
  const ColorSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {},
      child: const fluent.ListTile(
        leading: Icon(Icons.color_lens_outlined),
        title: Text('Color Accent'),
        trailing: Text('Default'),
      ),
    );
  }
}
