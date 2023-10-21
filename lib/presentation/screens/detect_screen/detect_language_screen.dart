import 'package:flutter/material.dart';

import '/core/constant/styles.dart';
import '/presentation/widgets/translator_text_box.dart';
import '/presentation/screens/detect_screen/components/detected_language_card.dart';

class DetectScreen extends StatelessWidget {
  const DetectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: paddingDefault * 3,
            left: paddingDefault,
            right: paddingDefault,
            bottom: paddingDefault,
          ),
          child: Stack(
            children: [
              ListView(
                children: [
                  Text(
                    "Detect Languages",
                    style: textTheme.titleLarge
                        ?.copyWith(color: colorScheme.onBackground),
                  ),
                  Divider(
                    color: colorScheme.outline,
                    height: paddingDefault * 2,
                  ),
                  TranslatorTextBox(
                    title: "Detect text language",
                    hintText: 'Enter text to detect it\'s language ...',
                    controller: TextEditingController(),
                    onClearTap: () {},
                    onChanged: (val) {
                      print(val);
                    },
                  ),
                  const SizedBox(height: paddingDefault),
                  const DetectedLanguageCard(
                    language: 'English',
                    confidencePercentage: 54,
                    reliable: true,
                  ),
                  const Spacer(),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: double.maxFinite),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text("Detect"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
