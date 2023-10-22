import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '/data/models/language.dart';
import '/data/repositories/local/hive_repo.dart';
import '/data/repositories/local/local_repo_interface.dart';
import '/data/repositories/remote/google_translator_repo.dart';
import '/data/repositories/remote/translator_repo_interface.dart';

part 'languages_event.dart';
part 'languages_state.dart';

class LanguagesBloc extends Bloc<LanguagesEvent, LanguagesState> {
  final LocalRepo localRepo = HiveRepo();
  final TranslatorRepo translatorRepo = GoogleTranslatorRepo();
  Language sourceLanguage = Language(
    code: 'en',
    name: 'English',
    nativeName: "",
  );

  Language targetLanguage = Language(
    code: 'hi',
    name: 'Hindi',
    nativeName: "हिन्दी",
  );
  List<Language> languages = [];
  List<Language> searchFilterLanguages = [];

  LanguagesBloc() : super(LanguagesInitialState()) {
    on<LanguagesInitialEvent>(_languageInitialEvent);
    on<LanguageSelectEvent>(_languageSelectEvent);
    on<LanguageSearchEvent>(_languageSearchEvent);
    on<LanguageSwapEvent>(_languageSwapEvent);
  }

  FutureOr<void> _languageInitialEvent(
      LanguagesInitialEvent event, Emitter<LanguagesState> emit) async {
    emit(LanguagesLoadingState());
    try {
      languages = await translatorRepo.getAllAvailableLanguages();
      emit(
        LanguagesLoadedState(
          languages: languages,
          sourceLanguage: sourceLanguage,
          targetLanguage: targetLanguage,
        ),
      );
    } catch (e) {
      emit(LanguagesErrorState());
    }
  }

  _languageSelectEvent(
      LanguageSelectEvent event, Emitter<LanguagesState> emit) {
    if (event.sourceLanguage != null) {
      sourceLanguage = event.sourceLanguage!;
    }
    if (event.targetLanguage != null) {
      targetLanguage = event.targetLanguage!;
    }
    emit(
      LanguagesLoadedState(
        languages: languages,
        sourceLanguage: sourceLanguage,
        targetLanguage: targetLanguage,
      ),
    );
  }

  _languageSearchEvent(
      LanguageSearchEvent event, Emitter<LanguagesState> emit) {
    searchFilterLanguages = languages
        .where(
          (element) => element.name.toString().toLowerCase().contains(
                event.searchText.toString().toLowerCase(),
              ),
        )
        .toList();

    emit(
      LanguagesLoadedState(
        languages: event.searchText.isEmpty ? languages : searchFilterLanguages,
        sourceLanguage: sourceLanguage,
        targetLanguage: targetLanguage,
      ),
    );
  }

  _languageSwapEvent(LanguageSwapEvent event, Emitter<LanguagesState> emit) {
    Language temp = targetLanguage;
    targetLanguage = sourceLanguage;
    sourceLanguage = temp;
    emit(
      LanguagesLoadedState(
        languages: languages,
        sourceLanguage: sourceLanguage,
        targetLanguage: targetLanguage,
      ),
    );
  }
}
