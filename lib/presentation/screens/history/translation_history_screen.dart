import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/domain/bloc/history/history_bloc.dart';
import '/core/constant/styles.dart';
import '/presentation/screens/translate_screen/components/language_code_circle.dart';
import '/presentation/widgets/custom_card.dart';
import '/presentation/widgets/loader.dart';
import 'components/list_heading.dart';

class TranslationHistoryScreen extends StatefulWidget {
  const TranslationHistoryScreen({super.key});

  @override
  State<TranslationHistoryScreen> createState() =>
      _TranslationHistoryScreenState();
}

class _TranslationHistoryScreenState extends State<TranslationHistoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HistoryBloc>().add(HistoryLoadTranslationEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: paddingDefault),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ListHeading(title: 'Translation History'),
              Expanded(
                child: BlocBuilder<HistoryBloc, HistoryState>(
                    builder: (context, state) {
                  if (state is HistoryTranslationLoadingState) {
                    return const Loader();
                  } else if (state is HistoryTranslationLoadedState) {
                    return ListView.builder(
                      itemCount: state.translationList.length,
                      itemBuilder: (context, index) {
                        final translation = state.translationList[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: paddingDefault / 3),
                          child: CustomCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                translationBox(
                                  context,
                                  translation.source ?? "",
                                  translation.text ?? "",
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.keyboard_double_arrow_down_sharp,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                                translationBox(
                                  context,
                                  translation.target ?? "",
                                  translation.translatedText ?? "",
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text(
                        "Something went Wrong or \nThere may may not be any history yet",
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                }),
              )
            ],
          ),
        ),
      ),
    );
  }

  CustomCard translationBox(BuildContext context, String lang, String text) {
    return CustomCard(
      hasOutline: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          LanguageCodeCircle(
            color: Theme.of(context).colorScheme.surface,
            languageCode: lang,
          )
        ],
      ),
    );
  }
}
