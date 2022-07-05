import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:provider/provider.dart';
import 'package:seiormusic/modules/setting/providers/setting_provider.dart';
import 'package:seiormusic/widgets/error_dialog.dart';

class ImportMusicSetting extends StatelessWidget {
  const ImportMusicSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        try {
          await Provider.of<SettingProvider>(context, listen: false).addToDatabase();
        } on Exception catch (exception) {
          showDialog(
            context: context,
            builder: (context) => ErrorDialog(
              message: exception.toString(),
            ),
          );
        }
      },
      child: const fluent.ListTile(
        leading: Icon(Icons.folder_outlined),
        title: Text('Import Music'),
        trailing: Text('Import from local file'),
      ),
    );
  }
}
