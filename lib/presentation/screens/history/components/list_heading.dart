import 'package:flutter/material.dart';

import '/core/constant/styles.dart';
import '/presentation/widgets/custom_card.dart';

class ListHeading extends StatelessWidget {
  const ListHeading({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: paddingDefault / 3,
                top: paddingDefault,
                right: paddingDefault / 2,
              ),
              child: CustomCard(
                onTap: () => Navigator.pop(context),
                padding: const EdgeInsets.symmetric(
                    vertical: paddingDefault / 2, horizontal: paddingDefault),
                child: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: paddingDefault),
              child: Text(
                title,
                style: textTheme.titleLarge
                    ?.copyWith(color: colorScheme.onBackground),
              ),
            ),
          ],
        ),
        Divider(
          color: colorScheme.outline,
        ),
      ],
    );
  }
}
