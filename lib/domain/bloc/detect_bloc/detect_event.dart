part of 'detect_bloc.dart';

abstract class DetectEvent {}

class TextChangeDetectEvent extends DetectEvent {}

class ClearButttonPressDetectEvent extends DetectEvent {}

class DetectLanguageButtonPressEvent extends DetectEvent {
  DetectLanguageButtonPressEvent(this.text);
  final String text;
}
