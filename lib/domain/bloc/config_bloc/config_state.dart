part of 'config_bloc.dart';

abstract class ConfigState {
  final ThemeMode themeMode;

  ConfigState({required this.themeMode});
}

class ConfigInitialState extends ConfigState {
  ConfigInitialState() : super(themeMode: ThemeMode.dark);
}

class ConfigLoadedState extends ConfigState {
  ConfigLoadedState({required super.themeMode});
}
