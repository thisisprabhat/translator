part of 'config_bloc.dart';

abstract class ConfigEvent {}

class ConfigThemeModeChangeEvent extends ConfigEvent {
  final ThemeMode themeMode;
  ConfigThemeModeChangeEvent({required this.themeMode});
}

class ConfigInitialThemeEvent extends ConfigEvent {}
