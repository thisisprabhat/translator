import 'dart:convert';

import 'package:hive/hive.dart';

part 'translation.g.dart';

@HiveType(typeId: 0)
class Translation {
  Translation({
    this.text,
    this.source,
    this.target,
    this.translatedText,
  });
  @HiveField(0)
  String? text;
  @HiveField(1)
  String? translatedText;
  @HiveField(2)
  String? source;
  @HiveField(3)
  String? target;

  factory Translation.fromRawJson(String str) =>
      Translation.fromJson(json.decode(str));
  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
      translatedText: json['data']['translations'][0]['translatedText']);

  toJson() => {'q': text ?? '', 'source': source, 'target': target};

  copyWith({
    String? text,
    String? source,
    String? target,
    String? translatedText,
  }) {
    this.text = text ?? this.text;
    this.source = source ?? this.source;
    this.target = target ?? this.target;
    this.translatedText = translatedText ?? this.translatedText;
  }

  @override
  String toString() {
    return 'Translation(text: $text,source : $source,target: $target ,translatedText: $translatedText)';
  }
}
