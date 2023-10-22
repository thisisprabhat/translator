import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/utils/colored_log.dart';
import '/data/models/translation.dart';
import '/data/repositories/local/hive_repo.dart';
import '/data/repositories/remote/google_translator_repo.dart';

part 'translate_event.dart';
part 'translate_state.dart';

class TranslateBloc extends Bloc<TranslateEvent, TranslateState> {
  final GoogleTranslatorRepo repo = GoogleTranslatorRepo();
  Translation translation = Translation();
  Timer? _timer;

  TranslateBloc() : super(TranslateInitialState()) {
    on<TranslateTextChangeEvent>(_translateTextChangeEvent);
    on<TranslateScreenClearButtonEvent>(_translateScreenClearButtonEvent);
    on<TranslationLoadedEvent>(_translationLoadedEvent);
  }

  FutureOr<void> _translateTextChangeEvent(
      TranslateTextChangeEvent event, Emitter<TranslateState> emit) async {
    translation = event.translation;

    if (event.translation.text!.isEmpty) {
      emit(TranslateScreenClearButtonState());
      return;
    } else {
      emit(TranslateLoadingState());
    }

    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }

    _timer = Timer(
      const Duration(milliseconds: 1500),
      () async {
        try {
          ColoredLog.red('Triggered');
          final tempTranslation = await repo.translateText(translation);
          translation.translatedText = tempTranslation.translatedText;
          final localRepo = HiveRepo();
          localRepo.saveTranslation(translation);
          add(TranslationLoadedEvent());
        } catch (e) {
          emit(TranslateErrorState());
        }
      },
    );
  }

  _translateScreenClearButtonEvent(
      TranslateScreenClearButtonEvent event, Emitter<TranslateState> emit) {
    emit(TranslateScreenClearButtonState());
  }

  FutureOr<void> _translationLoadedEvent(
      TranslationLoadedEvent event, Emitter<TranslateState> emit) {
    emit(TranslateLoadedState(translation: translation));
  }
}
