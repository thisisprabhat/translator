part of 'language_bloc.dart';

abstract class LanguagesEvent {}

class LanguagesInitialEvent extends LanguagesEvent {}

class LanguageSelectEvent extends LanguagesEvent {
  final Language? sourceLanguage;
  final Language? targetLanguage;

  LanguageSelectEvent({this.sourceLanguage, this.targetLanguage});
}

class LanguageSwapEvent extends LanguagesEvent {}

class LanguageSearchEvent extends LanguagesEvent {
  final String searchText;
  LanguageSearchEvent({required this.searchText});
}
