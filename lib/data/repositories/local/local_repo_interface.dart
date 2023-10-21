import 'package:flutter/material.dart';

import '/data/models/detection.dart';
import '/data/models/translation.dart';
import '/data/repositories/local/hive_repo.dart';

abstract interface class LocalRepo {
  ///Here factory design pattern is used
  ///It will help us in case we need to use different local db
  ///We can smoothly do that here
  factory LocalRepo() {
    return HiveRepo();
  }

  ///It initializes the local db
  Future<void> initLocalDb();

  ///It gives the persisted [dark_mode] or [light_mode] of the app
  Future<ThemeMode> getThemeMode();

  ///It helps in persisting [dark_mode] or [light_mode] of the app
  Future<void> setThemeMode(ThemeMode themeMode);

  ///It saves the current translation to the local db
  Future<void> saveTranslation(Translation translation);

  ///It fetches all the saved translations from history
  Future<List<Translation>> getTranslationHistory();

  ///It saves the current detection to the local db
  Future<void> saveDetection(Detection detection);

  ///It fetches all the saved detections from history
  Future<List<Detection>> getDetectionHistory();
}
