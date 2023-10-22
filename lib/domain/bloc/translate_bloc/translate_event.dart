part of 'translate_bloc.dart';

abstract class TranslateEvent {}

class TranslateTextChangeEvent extends TranslateEvent {
  final Translation translation;

  TranslateTextChangeEvent({required this.translation});
}

class TranslateScreenClearButtonEvent extends TranslateEvent {}

class TranslationLoadedEvent extends TranslateEvent {
  TranslationLoadedEvent();
}
