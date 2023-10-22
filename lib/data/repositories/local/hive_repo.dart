import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '/core/utils/colored_log.dart';
import '/data/models/detection.dart';
import '/data/models/translation.dart';
import 'local_repo_interface.dart';

class HiveRepo implements LocalRepo {
  //!Box Constants
  static const configBox = 'configs';
  static const detectionBox = 'detections';
  static const translationBox = 'translations';

  @override
  Future<void> initLocalDb() async {
    await Hive.initFlutter();
    Hive
      ..registerAdapter(TranslationAdapter())
      ..registerAdapter(DetectionAdapter());

    try {
      await Hive.openBox(configBox);
      await Hive.openBox<Detection>(detectionBox);
      await Hive.openBox<Translation>(translationBox);
    } catch (e) {
      ColoredLog.red(e, name: "Init Hive Error");
    }
  }

  @override
  Future<void> setThemeMode(ThemeMode themeMode) async {
    try {
      var box = Hive.box(configBox);
      String theme;

      if (themeMode == ThemeMode.light) {
        theme = 'light';
      } else if (themeMode == ThemeMode.dark) {
        theme = 'dark';
      } else {
        theme = 'system';
      }
      ColoredLog.yellow(theme, name: 'setTheme');

      await box.put('theme', theme);
    } catch (e) {
      ColoredLog.red(e, name: 'SetThemeMode');
    }
  }

  @override
  Future<ThemeMode> getThemeMode() async {
    var box = Hive.box(configBox);
    String? theme = await box.get('theme');
    ColoredLog(theme, name: 'getTheme');

    if (theme == 'light') {
      return ThemeMode.light;
    } else if (theme == 'system') {
      return ThemeMode.system;
    } else {
      return ThemeMode.dark;
    }
  }

  @override
  Future<void> saveTranslation(Translation translation) async {
    try {
      var box = Hive.box<Translation>(translationBox);
      box.add(translation);
      ColoredLog.green(translation, name: "Translation Saved");
    } catch (e) {
      ColoredLog.red(e, name: 'SaveTranslation Error');
    }
  }

  @override
  Future<List<Translation>> getTranslationHistory() async {
    List<Translation> translationHistory = [];
    try {
      var box = Hive.box<Translation>(translationBox);
      translationHistory = box.values.toList();

      ColoredLog.green('Length ${translationHistory.length}',
          name: 'Getting Translation History');
      if (translationHistory.isEmpty) {
        throw Error();
      }
      return translationHistory;
    } catch (e) {
      ColoredLog(e, name: 'getTranslationHistory Error');
      rethrow;
    }
  }

  @override
  Future<void> saveDetection(Detection detection) async {
    try {
      var box = Hive.box<Detection>(detectionBox);
      box.add(detection);
      ColoredLog.green(detection, name: 'Detection Saved');
    } catch (e) {
      ColoredLog.red(e, name: 'SaveDectaction Error');
    }
  }

  @override
  Future<List<Detection>> getDetectionHistory() async {
    List<Detection> detectionHistory = [];
    try {
      var box = Hive.box<Detection>(detectionBox);

      detectionHistory = box.values.toList();
      ColoredLog.green('Length ${detectionHistory.length}',
          name: 'Getting detection History');
      if (detectionHistory.isEmpty) {
        throw Error();
      }
      return detectionHistory;
    } catch (e) {
      ColoredLog(e, name: 'getDetectionHistory Error');
      rethrow;
    }
  }

  //!Singleton
  static final HiveRepo _instance = HiveRepo._internal();

  factory HiveRepo() {
    return _instance;
  }

  HiveRepo._internal();
}
