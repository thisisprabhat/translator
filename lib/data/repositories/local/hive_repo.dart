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
    await Hive.openBox(configBox);
    await Hive.openBox(detectionBox);
    await Hive.openBox(translationBox);
  }

  @override
  Future<void> setThemeMode(ThemeMode themeMode) async {
    var box = Hive.box(configBox);
    String theme;

    if (themeMode == ThemeMode.light) {
      theme = 'light';
    } else if (themeMode == ThemeMode.dark) {
      theme = 'dark';
    } else {
      theme = 'system';
    }

    await box.put('theme', theme);
  }

  @override
  Future<ThemeMode> getThemeMode() async {
    var box = Hive.box(configBox);
    String? theme = await box.get('theme');

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
      var box = Hive.box(translationBox);
      box.add(translation);
    } catch (e) {
      ColoredLog.red(e, name: 'SaveTranslation Error');
    }
  }

  @override
  Future<List<Translation>> getTranslationHistory() async {
    List<Translation> translationHistory = [];
    try {
      var box = Hive.box(translationBox);

      box.keys.map((key) async {
        translationHistory.clear();
        var value = await box.get(key);
        if (value is Translation) {
          translationHistory.add(value);
        }
      });

      return translationHistory;
    } catch (e) {
      ColoredLog(e, name: 'getTranslationHistory Error');
    }
    return translationHistory;
  }

  @override
  Future<void> saveDetection(Detection detection) async {
    try {
      var box = Hive.box(detectionBox);
      box.add(detection);
    } catch (e) {
      ColoredLog.red(e, name: 'SaveDectaction Error');
    }
  }

  @override
  Future<List<Detection>> getDetectionHistory() async {
    List<Detection> detectionHistory = [];
    try {
      var box = Hive.box(detectionBox);

      box.keys.map((key) async {
        detectionHistory.clear();
        var value = await box.get(key);
        if (value is Detection) {
          detectionHistory.add(value);
        }
      });

      return detectionHistory;
    } catch (e) {
      ColoredLog(e, name: 'getDetectionHistory Error');
    }
    return detectionHistory;
  }

  //!Singleton
  static final HiveRepo _instance = HiveRepo._internal();

  factory HiveRepo() {
    return _instance;
  }

  HiveRepo._internal();
}
