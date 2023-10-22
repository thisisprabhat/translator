import 'package:flutter/material.dart';

import '/presentation/screens/history/detection_history_screen.dart';
import '/presentation/screens/history/translation_history_screen.dart';
import '/presentation/screens/translate_screen/components/theme_dialog.dart';

class TopActionButtons extends StatelessWidget {
  const TopActionButtons({
    super.key,
    this.isTranslateScreen = true,
  });
  final bool isTranslateScreen;
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () => showDialog(
              context: context, builder: (context) => const ThemeDialog()),
          tooltip: 'theme',
          icon: Icon(
            colorScheme.brightness == Brightness.dark
                ? Icons.sunny
                : Icons.dark_mode,
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => isTranslateScreen
                    ? const TranslationHistoryScreen()
                    : const DetectionHistoryScreen(),
              ),
            );
          },
          tooltip: 'history',
          icon: const Icon(Icons.history),
        )
      ],
    );
  }
}
