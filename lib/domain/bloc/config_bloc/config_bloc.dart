import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator_app/data/repositories/local/hive_repo.dart';
import 'package:translator_app/data/repositories/local/local_repo_interface.dart';

part 'config_event.dart';
part 'config_state.dart';

class ConfigBloc extends Bloc<ConfigEvent, ConfigState> {
  final LocalRepo _repo = HiveRepo();
  ConfigBloc() : super(ConfigInitialState()) {
    on<ConfigThemeModeChangeEvent>(_configThemeModeChangeEvent);
    on<ConfigInitialThemeEvent>(_configInitialThemeEvent);
  }
  _configInitialThemeEvent(
      ConfigInitialThemeEvent event, Emitter<ConfigState> emit) async {
    final themeMode = await _repo.getThemeMode();
    emit(ConfigLoadedState(themeMode: themeMode));
  }

  _configThemeModeChangeEvent(
      ConfigThemeModeChangeEvent event, Emitter<ConfigState> emit) async {
    emit(ConfigLoadedState(themeMode: event.themeMode));
    await _repo.setThemeMode(event.themeMode);
  }
}
