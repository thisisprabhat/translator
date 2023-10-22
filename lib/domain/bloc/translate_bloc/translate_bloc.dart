import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator_app/data/repositories/remote/google_translator_repo.dart';

import '/data/models/translation.dart';

part 'translate_event.dart';
part 'translate_state.dart';

class TranslateBloc extends Bloc<TranslateEvent, TranslateState> {
  final GoogleTranslatorRepo repo = GoogleTranslatorRepo();
  Translation translation = Translation();
  Timer? _timer;

  TranslateBloc() : super(TranslateInitialState()) {
    on<TranslateTextChangeEvent>(_translateTextChangeEvent);
    on<TranslateScreenClearButtonEvent>(_translateScreenClearButtonEvent);
  }

  FutureOr<void> _translateTextChangeEvent(
      TranslateTextChangeEvent event, Emitter<TranslateState> emit) async {
    translation.text = event.text;

    if (event.text.isEmpty) {
      emit(TranslateScreenClearButtonState());
    } else {
      emit(TranslateLoadingState());
    }

    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }

    _timer = Timer(
      const Duration(seconds: 1),
      () async {
        try {
          translation = await repo.translateText(translation);
          emit(TranslateLoadedState(translation: translation));
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
}
