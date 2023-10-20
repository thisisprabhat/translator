import 'package:flutter/material.dart';

import '../../../../core/constant/styles.dart';
import '../../../widgets/custom_card.dart';

class DetectedLanguageCard extends StatelessWidget {
  const DetectedLanguageCard({
    super.key,
    this.language,
    this.confidencePercentage,
    this.reliable = false,
  });
  final bool reliable;
  final double? confidencePercentage;
  final String? language;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return CustomCard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text('Reliable: '),
                  Text(
                    reliable ? 'Yes' : 'No',
                    style: TextStyle(color: colorScheme.onBackground),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text('Confidence : '),
                  Text(
                    '$confidencePercentage%',
                    style: TextStyle(color: colorScheme.onBackground),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(paddingDefault),
            child: Text(
              language ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colorScheme.secondary,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
