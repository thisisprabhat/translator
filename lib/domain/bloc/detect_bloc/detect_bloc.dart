import 'package:flutter_bloc/flutter_bloc.dart';

import '/data/repositories/remote/google_translator_repo.dart';
import '/data/repositories/remote/translator_repo_interface.dart';
import '/data/models/detection.dart';

part 'detect_event.dart';
part 'detect_state.dart';

class DetectBloc extends Bloc<DetectEvent, DetectState> {
  DetectBloc() : super(DetectionInitialState()) {
    on<TextChangeDetectEvent>(_textChangeDetectEvent);
    on<DetectLanguageButtonPressEvent>(_detectLanguageButtonPressEvent);
    on<ClearButttonPressDetectEvent>(_clearButttonPressDetectEvent);
  }

  _textChangeDetectEvent(
      TextChangeDetectEvent event, Emitter<DetectState> emit) {
    emit(DetectionInitialState());
  }

  _detectLanguageButtonPressEvent(
      DetectLanguageButtonPressEvent event, Emitter<DetectState> emit) async {
    TranslatorRepo repo = GoogleTranslatorRepo();
    try {
      emit(DetectingState());
      final detection = await repo.detectTextLanguage(event.text);
      emit(DetectedState(detection: detection));
    } catch (e) {
      emit(DetectionErrorState());
    }
  }

  _clearButttonPressDetectEvent(
      ClearButttonPressDetectEvent event, Emitter<DetectState> emit) {
    emit(DetectionClearState());
  }
}
