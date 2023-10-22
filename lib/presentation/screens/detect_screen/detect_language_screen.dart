import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/constant/styles.dart';
import '/presentation/widgets/translator_text_box.dart';
import '/domain/bloc/detect_bloc/detect_bloc.dart';
import '/presentation/screens/detect_screen/components/detected_language_card.dart';

class DetectScreen extends StatefulWidget {
  const DetectScreen({super.key});

  @override
  State<DetectScreen> createState() => _DetectScreenState();
}

class _DetectScreenState extends State<DetectScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: paddingDefault * 3,
            left: paddingDefault,
            right: paddingDefault,
            bottom: paddingDefault,
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Detect Languages",
                    style: textTheme.titleLarge
                        ?.copyWith(color: colorScheme.onBackground),
                  ),
                  Divider(
                    color: colorScheme.outline,
                    height: paddingDefault * 2,
                  ),
                  TranslatorTextBox(
                    title: "Detect text language",
                    hintText: 'Enter text to detect it\'s language ...',
                    controller: _controller,
                    onClearTap: () => context
                        .read<DetectBloc>()
                        .add(ClearButttonPressDetectEvent()),
                    onChanged: (val) => BlocProvider.of<DetectBloc>(context)
                        .add(TextChangeDetectEvent()),
                  ),
                  const SizedBox(height: paddingDefault),
                  BlocConsumer<DetectBloc, DetectState>(
                    builder: (context, state) {
                      if (state is DetectingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is DetectedState) {
                        return DetectedLanguageCard(
                          language: state.detection?.language,
                          confidencePercentage: state.detection?.confidence,
                          reliable: state.detection?.isReliable ?? true,
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                    listener: (context, state) {
                      print(state);
                      if (state is DetectionErrorState) {
                      } else if (state is DetectionClearState) {
                        setState(() {
                          _controller.clear();
                        });
                      }
                    },
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: double.maxFinite),
                  child: ElevatedButton(
                    onPressed: () => context
                        .read<DetectBloc>()
                        .add(DetectLanguageButtonPressEvent(_controller.text)),
                    child: const Text("Detect"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
