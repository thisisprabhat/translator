import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/constant/styles.dart';
import '/presentation/screens/translate_screen/components/language_selector.dart';
import '/presentation/screens/translate_screen/components/translate_top_action_buttons.dart';
import '/domain/bloc/languages_bloc/language_bloc.dart';
import '/domain/bloc/translate_bloc/translate_bloc.dart';
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
  void initState() {
    super.initState();
    //InitState implementation
  }

  @override
  void dispose() {
    _sourceController.dispose();
    _targetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(
            left: paddingDefault,
            right: paddingDefault,
          ),
          children: [
            const TranslateTopActionButtons(),
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
                  child: LanguageSelector(translateTo: false),
                ),
                IconButton(
                  onPressed: () =>
                      context.read<LanguagesBloc>().add(LanguageSwapEvent()),
                  icon: Icon(
                    Icons.swap_horiz_rounded,
                    color: colorScheme.outline,
                  ),
                  visualDensity:
                      const VisualDensity(horizontal: -4, vertical: -2),
                ),
                const Expanded(
                  child: LanguageSelector(translateTo: true),
                )
              ],
            ),
            const SizedBox(height: paddingDefault),
            TranslatorTextBox(
              title: "Translate from ",
              title2: '(${context.watch<LanguagesBloc>().sourceLanguage.name})',
              hintText: 'Enter text to translate ...',
              controller: _sourceController,
              onClearTap: () => context.read<TranslateBloc>().add(
                    TranslateScreenClearButtonEvent(),
                  ),
              onChanged: (val) => context.read<TranslateBloc>().add(
                    TranslateTextChangeEvent(text: val),
                  ),
            ),
            const SizedBox(height: paddingDefault / 2),
            BlocConsumer<TranslateBloc, TranslateState>(
              builder: (context, state) {
                String loaderHint = 'your translated text will appear here.';
                if (state is TranslateLoadingState) {
                  loaderHint = 'Translating...';
                } else if (state is TranslateErrorState) {
                  loaderHint = 'Something went Wrong';
                }
                return TranslatorTextBox(
                  title: "Translate to ",
                  title2:
                      '(${context.watch<LanguagesBloc>().targetLanguage.name})',
                  hintText: loaderHint,
                  controller: _targetController,
                  onClearTap: () => context
                      .read<TranslateBloc>()
                      .add(TranslateScreenClearButtonEvent()),
                  readOnly: true,
                );
              },
              listener: (context, state) {
                if (state is TranslateScreenClearButtonState) {
                  setState(() {
                    _sourceController.clear();
                    _sourceController.clear();
                  });
                } else if (state is TranslateLoadedState) {
                  setState(() {
                    _targetController.text =
                        state.translation.translatedText ?? "";
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
