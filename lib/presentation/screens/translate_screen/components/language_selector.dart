import 'package:flutter/material.dart';

import '/core/constant/styles.dart';
import '/presentation/widgets/custom_card.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector(
      {super.key, required this.languageCode, required this.language});
  final String languageCode;
  final String language;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return CustomCard(
      onTap: () {},
      hasOutline: true,
      padding: const EdgeInsets.all(paddingDefault / 3),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.background,
            ),
            margin: const EdgeInsets.only(right: paddingDefault / 3),
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(bottom: paddingDefault / 3),
              child: Text(
                languageCode,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Text(
            language,
            style: TextStyle(color: colorScheme.onBackground),
          )
        ],
      ),
    );
  }
}
