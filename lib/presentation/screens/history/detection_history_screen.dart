import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/domain/bloc/history/history_bloc.dart';
import '/presentation/widgets/custom_card.dart';
import '/presentation/widgets/loader.dart';
import '/core/constant/styles.dart';
import '/core/utils/colored_log.dart';
import '/presentation/screens/translate_screen/components/language_code_circle.dart';
import 'components/list_heading.dart';

class DetectionHistoryScreen extends StatefulWidget {
  const DetectionHistoryScreen({super.key});

  @override
  State<DetectionHistoryScreen> createState() => _DetectionHistoryScreenState();
}

class _DetectionHistoryScreenState extends State<DetectionHistoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HistoryBloc>().add(HistoryLoadDetectionEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: paddingDefault),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ListHeading(title: 'Detection History'),
              Expanded(
                child: BlocBuilder<HistoryBloc, HistoryState>(
                  builder: (context, state) {
                    if (state is HistoryDetectionLoadingState) {
                      return const Loader();
                    } else if (state is HistoryDetectionLoadedState) {
                      return ListView.builder(
                        itemCount: state.detectionList.length,
                        itemBuilder: (context, index) {
                          final detection = state.detectionList[index];
                          return CustomCard(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    LanguageCodeCircle(
                                        languageCode: detection.language ?? ""),
                                    Text(detection.text ?? ""),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: Text(
                          "Something went Wrong or \nThere may may not be any history yet",
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
