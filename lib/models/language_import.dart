import 'package:json_annotation/json_annotation.dart';
part 'language_import.g.dart';

@JsonSerializable(explicitToJson: true)
class LanguageImport{
  LanguageImport(
      {
        required this.md5,
        required this.language,
        required this.path
      }
      );
  factory LanguageImport.fromJson(Map<String, dynamic> json) => _$LanguageImportFromJson(json);

  final String md5;
  final String language;
  final String path;

  Map<String, dynamic> toJson() => _$LanguageImportToJson(this);
}