import 'dart:async' show Future;
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_getx_boilerplate/lang/translation_service.dart';

Future<String> loadJsonFromAsset(String language) async {
  try{
    //////////////////////////////////////////////////////////////////////////////////////////////////////
    // For translation downloaded from backend, if not used then comment the block out
    final File downloadedFile = await getLocalFile(language + '.json');
    if(downloadedFile.existsSync()){
      return downloadedFile.readAsStringSync();
    }
    /////////////////////////////////////////////////////////////////////////////////////////////
    return await rootBundle.loadString('assets/i18n/' + language + '.json');
  }
  catch(e){
    return await rootBundle.loadString('assets/i18n/' + language + '.json');
  }
}

Map<String, String> _convertValueToString(Map<String, dynamic> obj) {
  final Map<String, String> result = {};
  obj.forEach((String key, dynamic value) {
    result[key] = value.toString();
  });
  return result;
}

Future<Map<String, Map<String, String>>> initializeI18n() async {
  final Map<String, Map<String, String>> values = {};
  for (final String language in languages) {
    final Map<String, dynamic> translation =
      json.decode(await loadJsonFromAsset(language)) as Map<String, dynamic>;
    values[language] = _convertValueToString(translation);
  }
  return values;
}