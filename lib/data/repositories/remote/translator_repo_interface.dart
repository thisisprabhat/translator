import '/data/models/detection.dart';
import '/data/models/language.dart';
import '/data/models/translation.dart';

abstract interface class TranslatorRepo {
  ///It translates the given text
  Future<Translation> translateText(Translation translation);

  ///It detects the language of the given text
  Future<Detection> detectTextLanguage(Detection detection);

  ///It fetches all the available languages for translatioin
  Future<List<Language>> getAllAvailableLanguages();
}
