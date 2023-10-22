import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator_app/domain/bloc/languages_bloc/language_bloc.dart';
import 'package:translator_app/domain/bloc/translate_bloc/translate_bloc.dart';

import 'core/config/app_themes.dart';
import 'data/repositories/local/hive_repo.dart';
import 'domain/bloc/config_bloc/config_bloc.dart';
import 'domain/bloc/detect_bloc/detect_bloc.dart';
import 'presentation/screens/homescreen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final localRepo = HiveRepo();
  await localRepo.initLocalDb();

  runApp(const TranslatorApp());
}

class TranslatorApp extends StatelessWidget {
  const TranslatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => DetectBloc()),
        BlocProvider(create: (_) => TranslateBloc()),
        BlocProvider(
            create: (_) => ConfigBloc()..add(ConfigInitialThemeEvent())),
        BlocProvider(
            create: (_) => LanguagesBloc()..add(LanguagesInitialEvent())),
      ],
      child: BlocBuilder<ConfigBloc, ConfigState>(
        builder: (_, state) => MaterialApp(
          title: 'Translator App',
          home: const HomeScreen(),
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: state.themeMode,
        ),
      ),
    );
  }
}
