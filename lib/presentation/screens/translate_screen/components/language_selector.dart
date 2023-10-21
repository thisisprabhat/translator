import 'dart:ui';

import 'package:flutter/material.dart';

import '/presentation/widgets/all_languages_widget.dart';
import '/core/constant/styles.dart';
import '/data/models/language.dart';
import '/presentation/widgets/custom_card.dart';
import '/presentation/widgets/language_code_circle.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({
    super.key,
    required this.language,
    this.translateTo = false,
  });
  final Language language;
  final bool translateTo;

  _showBottomSheet(context) {
    showBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadiusDefault.copyWith(
          bottomLeft: Radius.zero,
          bottomRight: Radius.zero,
        ),
      ),
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
              // blendMode: BlendMode.clear,
              child: Container(
                color: Colors.transparent,
                height: double.maxFinite,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.7,
              child: AllLanguages(
                translateTo: translateTo,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return CustomCard(
      onTap: () => _showBottomSheet(context),
      hasOutline: true,
      padding: const EdgeInsets.all(paddingDefault / 3),
      child: Row(
        children: [
          LanguageCodeCircle(languageCode: language.code ?? ""),
          Text(
            language.name ?? "",
            style: TextStyle(color: colorScheme.onBackground),
          )
        ],
      ),
    );
  }
}
