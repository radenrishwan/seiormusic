import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter_svg/flutter_svg.dart';

class EmptyWidget extends StatelessWidget {
  final String title;

  const EmptyWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const fluent.SizedBox(height: 50),
        SvgPicture.asset(
          'assets/illustrations/loading.svg',
          fit: fluent.BoxFit.cover,
          height: 200,
        ),
        const fluent.SizedBox(height: 25),
        fluent.Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
