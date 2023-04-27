// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_import.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LanguageImport _$LanguageImportFromJson(Map<String, dynamic> json) {
  return LanguageImport(
    md5: json['md5'] as String,
    language: json['language'] as String,
    path: json['path'] as String,
  );
}

Map<String, dynamic> _$LanguageImportToJson(LanguageImport instance) =>
    <String, dynamic>{
      'md5': instance.md5,
      'language': instance.language,
      'path': instance.path,
    };
