import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator_app/core/utils/colored_log.dart';
import 'package:translator_app/domain/bloc/languages_bloc/language_bloc.dart';

import '/data/models/language.dart';
import '/core/constant/styles.dart';
import '/presentation/widgets/custom_card.dart';
import 'languages_card.dart';

class AllLanguages extends StatelessWidget {
  const AllLanguages({
    super.key,
    this.translateTo = false,
  });
  final bool translateTo;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return CustomCard(
      hasOutline: true,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      padding: const EdgeInsets.only(
        top: paddingDefault,
        left: paddingDefault,
        right: paddingDefault,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: paddingDefault / (3 / 2),
                bottom: paddingDefault / (3 / 2)),
            child: Text(
              translateTo ? "To" : "From",
              style: TextStyle(
                color: colorScheme.onSurface,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          TextField(
            onChanged: (val) {
              context
                  .read<LanguagesBloc>()
                  .add(LanguageSearchEvent(searchText: val));
            },
            decoration: InputDecoration(
              hintText: "Search for languages..",
              focusColor: colorScheme.outline,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: colorScheme.outline),
                borderRadius: borderRadiusDefault,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorScheme.surfaceVariant),
                borderRadius: borderRadiusDefault,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(paddingDefault / (3 / 2)),
            child: Text(
              "All Languages",
              style: TextStyle(
                color: colorScheme.onSurface,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<LanguagesBloc, LanguagesState>(
              builder: (context, state) {
                ColoredLog.yellow(state);
                if (state is LanguagesLoadedState) {
                  return ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: paddingDefault / 3),
                      itemCount: state.languages.length,
                      itemBuilder: (context, index) {
                        final Language language = state.languages[index];
                        bool isSelected = false;
                        if (translateTo) {
                          isSelected =
                              language.code == state.targetLanguage.code;
                        } else {
                          {
                            isSelected =
                                language.code == state.sourceLanguage.code;
                          }
                        }
                        return LanguageCard(
                          onTap: () {
                            context.read<LanguagesBloc>().add(
                                  translateTo
                                      ? LanguageSelectEvent(
                                          targetLanguage: language)
                                      : LanguageSelectEvent(
                                          sourceLanguage: language,
                                        ),
                                );
                            Navigator.pop(context);
                          },
                          language: language,
                          isSelected: isSelected,
                        );
                      });
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
