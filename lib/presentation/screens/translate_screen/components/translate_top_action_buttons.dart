import 'package:flutter/material.dart';

import '/presentation/screens/history/history_screen.dart';
import 'theme_dialog.dart';

class TranslateTopActionButtons extends StatelessWidget {
  const TranslateTopActionButtons({
    super.key,
  });

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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HistoryScreen()));
          },
          tooltip: 'history',
          icon: const Icon(Icons.history),
        )
      ],
    );
  }
}
