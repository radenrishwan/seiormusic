import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;

class LanguageSetting extends StatelessWidget {
  const LanguageSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {},
      child: const fluent.ListTile(
        leading: Icon(Icons.language),
        title: Text('Language'),
        trailing: Text('English'),
      ),
    );
  }
}
