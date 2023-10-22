part of 'translate_bloc.dart';

abstract class TranslateState {}

class TranslateScreenClearButtonState extends TranslateState {}

class TranslateLoadingState extends TranslateState {}

class TranslateInitialState extends TranslateState {}

class TranslateErrorState extends TranslateState {}

class TranslateLoadedState extends TranslateState {
  final Translation translation;
  TranslateLoadedState({required this.translation});
}
