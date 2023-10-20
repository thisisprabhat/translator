import 'package:flutter/material.dart';

import '/core/constant/styles.dart';
import '/presentation/screens/translate_screen/components/language_selector.dart';
import '/presentation/widgets/translator_text_box.dart';

class TranslateScreen extends StatefulWidget {
  const TranslateScreen({super.key});

  @override
  State<TranslateScreen> createState() => _TranslateScreenState();
}

class _TranslateScreenState extends State<TranslateScreen> {
  final TextEditingController _sourceController = TextEditingController();
  final TextEditingController _targetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(
            top: paddingDefault * 3,
            left: paddingDefault,
            right: paddingDefault,
          ),
          children: [
            Text(
              "Text Translation",
              style: textTheme.titleLarge
                  ?.copyWith(color: colorScheme.onBackground),
            ),
            Divider(
              color: colorScheme.outline,
              height: paddingDefault * 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Expanded(
                  child: LanguageSelector(
                    language: 'English',
                    languageCode: 'en',
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.swap_horiz_rounded,
                    color: colorScheme.outline,
                  ),
                  visualDensity:
                      const VisualDensity(horizontal: -4, vertical: -2),
                ),
                const Expanded(
                  child: LanguageSelector(
                    language: "German",
                    languageCode: 'ge',
                  ),
                )
              ],
            ),
            const SizedBox(height: paddingDefault),
            TranslatorTextBox(
              title: "Translate from ",
              title2: '(English)',
              hintText: 'Enter text to translate ...',
              controller: _sourceController,
              onClearTap: () {},
              onChanged: (val) {
                setState(() {});
              },
            ),
            const SizedBox(height: paddingDefault / 2),
            TranslatorTextBox(
              title: "Translate to ",
              title2: '(Germany)',
              hintText: 'your translated text will appear here.',
              controller: _targetController,
              onClearTap: () {},
              readOnly: true,
              onChanged: (val) {
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
