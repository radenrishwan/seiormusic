import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final List<Widget> childern;

  const CustomDialog({
    super.key,
    required this.childern,
  });

  @override
  Widget build(BuildContext context) {
    return fluent.Align(
      alignment: fluent.Alignment.topCenter,
      child: fluent.Container(
        margin: const fluent.EdgeInsets.all(12),
        child: Material(
          borderRadius: fluent.BorderRadius.circular(12),
          color: Colors.white,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: fluent.Column(
              mainAxisSize: fluent.MainAxisSize.min,
              children: childern,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomListTile extends fluent.StatelessWidget {
  final Widget leading;
  final VoidCallback onTap;
  final Widget title;
  final Widget? subDialog;

  const CustomListTile({
    super.key,
    required this.leading,
    required this.onTap,
    required this.title,
    this.subDialog,
  });

  @override
  fluent.Widget build(fluent.BuildContext context) {
    return InkWell(
      onTap: () {
        if (subDialog != null) {
          showDialog(
            context: context,
            builder: (context) {
              return subDialog!;
            },
          ).then((value) => Navigator.pop(context));
        } else {
          Navigator.pop(context);
        }
      },
      child: fluent.ListTile(
        leading: leading,
        title: title,
      ),
    );
  }
}
