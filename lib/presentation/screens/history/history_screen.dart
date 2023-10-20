import 'package:flutter/material.dart';

import '/core/constant/styles.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: paddingDefault),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: paddingDefault * 3),
              Text(
                "History",
                style: textTheme.titleLarge
                    ?.copyWith(color: colorScheme.onBackground),
              ),
              Divider(
                color: colorScheme.outline,
                height: paddingDefault * 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
