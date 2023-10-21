import 'dart:convert';

import 'package:hive/hive.dart';

part 'detection.g.dart';

@HiveType(typeId: 1)
class Detection {
  Detection({
    this.text,
    this.language,
    this.isReliable,
    this.confidence,
  });
  @HiveField(0)
  String? text;
  @HiveField(1)
  String? language;
  @HiveField(2)
  bool? isReliable;
  @HiveField(3)
  num? confidence;

  factory Detection.fromRawJson(String str) =>
      Detection.fromJson(json.decode(str));
  factory Detection.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> data = json['data']['detections'][0][0];
    return Detection(
      language: data['language'],
      isReliable: data['isReliable'],
      confidence: ((data['confidence'] * 100)).roundToDouble(),
    );
  }
  toJson() => {'q': text ?? ''};
  copyWith({
    String? text,
    String? language,
    bool? isReliable,
    double? confidence,
  }) {
    this.text = text ?? this.text;
    this.isReliable = isReliable ?? this.isReliable;
    this.confidence = confidence ?? this.confidence;
    this.language = language ?? this.language;
  }

  @override
  String toString() {
    return 'Detection(text: $text,language: $language,isReliable: $isReliable,confidence: $confidence)';
  }
}
