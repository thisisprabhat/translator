part of 'detect_bloc.dart';

abstract class DetectEvent {}

class TextChangeDetectEvent extends DetectEvent {
  final String text;
  TextChangeDetectEvent({required this.text});
}

class ClearButttonPressDetectEvent extends DetectEvent {}

class DetectLanguageButtonPressEvent extends DetectEvent {}
