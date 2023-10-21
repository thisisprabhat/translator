import 'package:flutter/material.dart';

import '/core/constant/styles.dart';

class LanguageCodeCircle extends StatelessWidget {
  const LanguageCodeCircle({
    super.key,
    required this.languageCode,
    this.color,
  });

  final String languageCode;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color ?? Theme.of(context).colorScheme.background,
      ),
      margin: const EdgeInsets.only(right: paddingDefault / 3),
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(bottom: paddingDefault / 5),
        child: Text(
          languageCode,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
