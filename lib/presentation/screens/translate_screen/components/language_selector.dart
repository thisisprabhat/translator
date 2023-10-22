import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator_app/domain/bloc/languages_bloc/language_bloc.dart';

import '../../../../data/models/language.dart';
import 'all_languages_widget.dart';
import '/core/constant/styles.dart';
import '/presentation/widgets/custom_card.dart';
import 'language_code_circle.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({
    super.key,
    this.translateTo = false,
  });
  final bool translateTo;

  _showBottomSheet(context) async {
    showBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadiusDefault.copyWith(
          bottomLeft: Radius.zero,
          bottomRight: Radius.zero,
        ),
      ),
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
              child: Container(
                color: Colors.transparent,
                height: double.maxFinite,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.7,
              child: AllLanguages(
                translateTo: translateTo,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return CustomCard(
      onTap: () => _showBottomSheet(context),
      hasOutline: true,
      padding: const EdgeInsets.all(paddingDefault / 3),
      child: BlocBuilder<LanguagesBloc, LanguagesState>(
        builder: (context, state) {
          Language language = translateTo
              ? Language(
                  code: 'hi',
                  name: 'Hindi',
                  nativeName: "हिन्दी",
                )
              : Language(
                  code: 'en',
                  name: 'English',
                  nativeName: "",
                );
          if (state is LanguagesLoadedState) {
            language =
                translateTo ? state.targetLanguage : state.sourceLanguage;
          }
          return Row(
            children: [
              LanguageCodeCircle(languageCode: language.code ?? ""),
              Text(
                language.name ?? "",
                style: TextStyle(color: colorScheme.onBackground),
              )
            ],
          );
        },
      ),
    );
  }
}
