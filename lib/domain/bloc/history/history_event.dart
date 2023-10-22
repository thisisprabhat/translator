part of 'history_bloc.dart';

abstract class HistoryEvent {}

class HistoryLoadTranslationEvent extends HistoryEvent {}

class HistoryLoadDetectionEvent extends HistoryEvent {}
