import 'package:dexter_test/app/presentation/theme/text.dart';
import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title});
  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        DefaultTextStyle(
          style: MyTextStyles.bold.copyWith(color: Colors.black),
          child: title,
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
