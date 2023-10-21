import 'package:flutter/material.dart';

import '/data/models/language.dart';
import '/core/constant/styles.dart';
import 'custom_card.dart';
import 'language_code_circle.dart';

class AllLanguages extends StatelessWidget {
  const AllLanguages({
    super.key,
    this.translateTo = false,
  });
  final bool translateTo;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return CustomCard(
      hasOutline: true,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      padding: const EdgeInsets.only(
        top: paddingDefault,
        left: paddingDefault,
        right: paddingDefault,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: paddingDefault / (3 / 2),
                bottom: paddingDefault / (3 / 2)),
            child: Text(
              translateTo ? "To" : "From",
              style: TextStyle(
                color: colorScheme.onSurface,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          TextField(
            decoration: InputDecoration(
              focusColor: colorScheme.outline,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: colorScheme.outline),
                borderRadius: borderRadiusDefault,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorScheme.surfaceVariant),
                borderRadius: borderRadiusDefault,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(paddingDefault / (3 / 2)),
            child: Text(
              "All Languages",
              style: TextStyle(
                color: colorScheme.onSurface,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) =>
                  const SizedBox(height: paddingDefault / 3),
              itemCount: 10,
              itemBuilder: (context, index) => LanguageCard(
                language: Language(
                  code: 'en',
                  name: "English",
                  nativeName: "English",
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class LanguageCard extends StatelessWidget {
  const LanguageCard({
    super.key,
    required this.language,
  });
  final Language language;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return CustomCard(
      padding: const EdgeInsets.all(paddingDefault / 2),
      backgroundColor: colorScheme.background,
      child: Row(
        children: [
          LanguageCodeCircle(
            languageCode: language.code ?? "",
            color: colorScheme.surface,
          ),
          Expanded(
            child: Text(
              '${language.name}, ${language.nativeName?.split(',').first ?? ""}',
            ),
          )
        ],
      ),
    );
  }
}
