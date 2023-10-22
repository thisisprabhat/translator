part of 'history_bloc.dart';

abstract class HistoryState {}

class HistoryInitialState extends HistoryState {}

class HistoryTranslationLoadingState extends HistoryState {}

class HistoryTranslationLoadedState extends HistoryState {
  final List<Translation> translationList;

  HistoryTranslationLoadedState(this.translationList);
}

class HistoryTranslationErrorState extends HistoryState {}

class HistoryDetectionLoadingState extends HistoryState {}

class HistoryDetectionLoadedState extends HistoryState {
  final List<Detection> detectionList;

  HistoryDetectionLoadedState(this.detectionList);
}

class HistoryDetectionErrorState extends HistoryState {}
