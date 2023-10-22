import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/utils/colored_log.dart';
import '/data/repositories/local/hive_repo.dart';
import '/data/repositories/local/local_repo_interface.dart';

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
    ColoredLog.yellow('ConfigInitialThemeEvent');
    final themeMode = await _repo.getThemeMode();
    ColoredLog.green(themeMode, name: 'Get ThemeMode form local DB');
    emit(ConfigLoadedState(themeMode: themeMode));
  }

  _configThemeModeChangeEvent(
      ConfigThemeModeChangeEvent event, Emitter<ConfigState> emit) async {
    emit(ConfigLoadedState(themeMode: event.themeMode));
    await _repo.setThemeMode(event.themeMode);
  }
}
