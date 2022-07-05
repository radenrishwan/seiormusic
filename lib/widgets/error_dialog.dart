import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String message;

  const ErrorDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return fluent.ContentDialog(
      title: Text(
        'Error occurred',
        style: TextStyle(
          fontSize: Theme.of(context).textTheme.headline6!.fontSize ?? 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(message),
      actions: [
        fluent.Button(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
