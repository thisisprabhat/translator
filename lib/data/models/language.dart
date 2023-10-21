// ignore_for_file: hash_and_equals

import 'dart:convert';

class Language {
  final String? code;
  final String? name;
  final String? nativeName;

  Language({
    this.code,
    this.name,
    this.nativeName,
  });

  Language copyWith({
    String? code,
    String? name,
    String? nativeName,
  }) =>
      Language(
        code: code ?? this.code,
        name: name ?? this.name,
        nativeName: nativeName ?? this.nativeName,
      );

  factory Language.fromRawJson(String str) =>
      Language.fromJson(json.decode(str));

  factory Language.fromJson(Map<String, dynamic> json) => Language(
        code: json["code"],
        name: json["name"],
        nativeName: json["nativeName"],
      );

  @override
  toString() {
    return "Language(code: $code,name: $name,nativeName: $nativeName)";
  }
}
