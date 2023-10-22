import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/constant/styles.dart';
import '/domain/bloc/config_bloc/config_bloc.dart';

class ThemeDialog extends StatelessWidget {
  const ThemeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
        child: const SizedBox(
          height: double.maxFinite,
          width: double.maxFinite,
          child: Center(
            child: SizedBox(
              height: 200,
              width: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ThemeBox(
                          boxThemeMode: ThemeMode.dark,
                          topLeft: true,
                        ),
                      ),
                      SizedBox(width: paddingDefault / 5),
                      Expanded(
                        child: ThemeBox(
                          boxThemeMode: ThemeMode.light,
                          topRight: true,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: paddingDefault / 5),
                  ThemeBox(
                    boxThemeMode: ThemeMode.system,
                    bottomLeft: true,
                    bottomRight: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ThemeBox extends StatelessWidget {
  const ThemeBox({
    super.key,
    required this.boxThemeMode,
    this.topLeft = false,
    this.topRight = false,
    this.bottomLeft = false,
    this.bottomRight = false,
  });
  final ThemeMode boxThemeMode;
  final bool topLeft;
  final bool topRight;
  final bool bottomLeft;
  final bool bottomRight;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<ConfigBloc, ConfigState>(
      builder: (context, state) => Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: borderRadiusDefault,
          onTap: () => context
              .read<ConfigBloc>()
              .add(ConfigThemeModeChangeEvent(themeMode: boxThemeMode)),
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: paddingDefault, vertical: paddingDefault / 2),
            decoration: BoxDecoration(
              color: state.themeMode == boxThemeMode
                  ? colorScheme.secondary
                  : colorScheme.surface,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(topLeft ? 15 : 5),
                topRight: Radius.circular(topRight ? 15 : 5),
                bottomLeft: Radius.circular(bottomLeft ? 15 : 5),
                bottomRight: Radius.circular(bottomRight ? 15 : 5),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  boxThemeMode == ThemeMode.dark
                      ? Icons.dark_mode
                      : boxThemeMode == ThemeMode.light
                          ? Icons.sunny
                          : Icons.phone_android,
                  color: state.themeMode == boxThemeMode
                      ? colorScheme.onSecondary
                      : colorScheme.onSurface,
                  size: 30,
                ),
                Text(
                  boxThemeMode == ThemeMode.dark
                      ? "Dark Mode"
                      : boxThemeMode == ThemeMode.light
                          ? "Light Mode"
                          : "System",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: state.themeMode == boxThemeMode
                        ? colorScheme.onSecondary
                        : colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
