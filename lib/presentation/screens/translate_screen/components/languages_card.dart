import 'package:flutter/material.dart';

import '/core/constant/styles.dart';
import '/data/models/language.dart';
import '/presentation/widgets/custom_card.dart';
import 'language_code_circle.dart';

class LanguageCard extends StatelessWidget {
  const LanguageCard({
    super.key,
    required this.language,
    this.isSelected = false,
    required this.onTap,
  });
  final Language language;
  final bool isSelected;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return CustomCard(
      onTap: onTap,
      padding: const EdgeInsets.all(paddingDefault / 2),
      backgroundColor:
          isSelected ? colorScheme.secondary : colorScheme.background,
      child: Row(
        children: [
          LanguageCodeCircle(
            languageCode: language.code ?? "",
            color: colorScheme.surface,
          ),
          Expanded(
            child: Text(
              '${language.name}, ${language.nativeName?.split(',').first ?? ""}',
              style: TextStyle(
                color: isSelected
                    ? colorScheme.onSecondary
                    : colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}
