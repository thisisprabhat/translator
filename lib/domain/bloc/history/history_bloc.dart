import 'package:flutter_bloc/flutter_bloc.dart';

import '/data/repositories/local/hive_repo.dart';
import '/data/repositories/local/local_repo_interface.dart';
import '/data/models/detection.dart';
import '/data/models/translation.dart';
import '/core/utils/colored_log.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final LocalRepo localRepo = HiveRepo();
  HistoryBloc() : super(HistoryInitialState()) {
    on<HistoryLoadTranslationEvent>(_historyEventTranslationLoad);
    on<HistoryLoadDetectionEvent>(_historyEventDetectionLoad);
  }

  _historyEventTranslationLoad(
      HistoryLoadTranslationEvent event, Emitter<HistoryState> emit) async {
    ColoredLog.yellow('HistoryLoadTranslationEvent');
    try {
      emit(HistoryTranslationLoadingState());
      final List<Translation> translationList =
          await localRepo.getTranslationHistory();
      emit(HistoryTranslationLoadedState(translationList));
    } catch (e) {
      emit(HistoryTranslationErrorState());
    }
  }

  _historyEventDetectionLoad(
      HistoryLoadDetectionEvent event, Emitter<HistoryState> emit) async {
    ColoredLog.yellow('HistoryLoadDetectionEvent');
    try {
      emit(HistoryDetectionLoadingState());
      final List<Detection> detectionList =
          await localRepo.getDetectionHistory();
      emit(HistoryDetectionLoadedState(detectionList));
    } catch (e) {
      emit(HistoryDetectionErrorState());
    }
  }
}
