part of 'translate_bloc.dart';

abstract class TranslateEvent {}

class TranslateTextChangeEvent extends TranslateEvent {
  final String text;

  TranslateTextChangeEvent({required this.text});
}

class TranslateScreenClearButtonEvent extends TranslateEvent {}
