import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator_app/domain/bloc/config_bloc/config_bloc.dart';

import 'core/config/app_themes.dart';
import '/domain/bloc/detect_bloc/detect_bloc.dart';
import 'presentation/screens/homescreen/home_screen.dart';

void main() {
  runApp(const TranslatorApp());
}

class TranslatorApp extends StatelessWidget {
  const TranslatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => DetectBloc()),
        BlocProvider(create: (_) => ConfigBloc()),
      ],
      child: BlocBuilder<ConfigBloc, ConfigState>(
        builder: (_, state) => MaterialApp(
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
