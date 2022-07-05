import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return fluent.Column(
      children: [
        const fluent.SizedBox(height: 50),
        SvgPicture.asset(
          'assets/illustrations/loading.svg',
          fit: fluent.BoxFit.cover,
          height: 200,
        ),
        const fluent.SizedBox(height: 25),
        fluent.Text(
          'Loading...',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
