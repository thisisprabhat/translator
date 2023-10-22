import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

import '/core/utils/colored_log.dart';
import '/core/constant/api_key.dart';
import '/core/constant/urls.dart';
import '/data/models/detection.dart';
import '/data/models/language.dart';
import '/data/models/translation.dart';
import '/data/repositories/local/hive_repo.dart';
import '/data/repositories/remote/translator_repo_interface.dart';

class GoogleTranslatorRepo implements TranslatorRepo {
  final localRepo = HiveRepo();

  final _headers = {
    'content-type': 'application/x-www-form-urlencoded',
    'Accept-Encoding': 'application/gzip',
    'X-RapidAPI-Key': apiKey,
    'X-RapidAPI-Host': 'google-translate1.p.rapidapi.com'
  };

  @override
  Future<List<Language>> getAllAvailableLanguages() async {
    ColoredLog(UrlConstant.allLanguagesUrl, name: "URL");
    ColoredLog.yellow(_headers, name: 'Headers');
    try {
      final dio = Dio();
      Response response = await dio.get(UrlConstant.allLanguagesUrl,
          options: Options(headers: _headers));

      if (response.statusCode == 200) {
        Map<String, dynamic> remoteData = response.data;
        List<dynamic> remoteList =
            remoteData['data']['languages'].map((e) => e['language']).toList();
        ColoredLog.yellow(remoteList.length, name: 'Remote List');

        final localData = jsonDecode(
          await rootBundle.loadString('assets/json/languages.json'),
        );

        List<dynamic> localList =
            localData.map((val) => Language.fromJson(val)).toList();
        ColoredLog.magenta(localList.length, name: 'Local List');

        List<Language> finalList = [];
        for (Language lang in localList) {
          if (remoteList.contains(lang.code)) {
            finalList.add(lang);
          }
        }
        ColoredLog.green(finalList.length, name: 'Final List');
        return finalList;
      } else {
        ColoredLog.red(response.data, name: 'response ${response.statusCode}');
      }
    } catch (e) {
      ColoredLog.red(e, name: 'getAllAvailableLanguages Error');
    }
    return [];
  }

  @override
  Future<Translation> translateText(Translation translation) async {
    ColoredLog(UrlConstant.translateUrl, name: "URL");
    ColoredLog.yellow(_headers, name: 'Headers');
    Map<String, dynamic> payload = {
      'q': translation.text.toString(),
      'source': translation.source.toString(),
      'target': translation.target.toString(),
    };
    ColoredLog.green(payload, name: 'Payload');
    try {
      final dio = Dio();
      Response response = await dio.post(
        UrlConstant.translateUrl,
        options: Options(headers: _headers),
        data: payload,
      );

      if (response.statusCode == 200) {
        Translation val = Translation.fromJson(response.data);
        val.text = translation.text;
        ColoredLog.yellow(val, name: 'Translation');
        return val;
      } else {
        ColoredLog.red(response.data, name: response.statusCode.toString());
      }
    } catch (e) {
      ColoredLog.red(e, name: 'translateText Error');
    }
    return Translation();
  }

  @override
  Future<Detection> detectTextLanguage(String detectionText) async {
    ColoredLog(UrlConstant.detectLanguageUrl, name: "URL");
    ColoredLog.yellow(_headers, name: 'Headers');
    Map<String, dynamic> payload = {
      'q': detectionText,
    };
    ColoredLog(payload, name: 'Payload');

    try {
      final dio = Dio();
      final response = await dio.post(
        UrlConstant.detectLanguageUrl,
        options: Options(headers: _headers),
        data: payload,
      );

      if (response.statusCode == 200) {
        Detection val = Detection.fromJson(response.data);
        val.text = detectionText;
        ColoredLog.yellow(val, name: 'Detection');
        await localRepo.saveDetection(val);
        return val;
      } else {
        ColoredLog.red(response.data, name: response.statusCode.toString());
      }
    } catch (e) {
      ColoredLog.red(e, name: 'detectionText Error');
    }
    return Detection();
  }
}
