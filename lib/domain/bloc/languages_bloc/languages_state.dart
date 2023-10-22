part of 'language_bloc.dart';

abstract class LanguagesState {}

class LanguagesInitialState extends LanguagesState {}

class LanguagesLoadingState extends LanguagesState {}

class LanguagesLoadedState extends LanguagesState {
  final Language sourceLanguage;
  final Language targetLanguage;
  final List<Language> languages;
  LanguagesLoadedState(
      {required this.languages,
      required this.sourceLanguage,
      required this.targetLanguage});
}

class LanguagesErrorState extends LanguagesState {}
