import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_getx_boilerplate/api/api.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../models/language_import.dart';
import '../shared/services/storage_service.dart';
import 'initialize_i18n.dart';

const List<String> languages = <String>['en', 'zh', 'ms'];

class TranslationService extends Translations {
  static final fallbackLocale = Locale('en', 'US');

  Future<void> init() async{
    //////////////////////////////////////////////////////////////////////////////////////////////////////
    // Comment out if not using for faster performance
    // Initiate download from backend
    try{
      // TODO - have to initiate an instance just for translation, because all other services are not ready yet
      // To be improved in future
      ApiRepository apiRepository = ApiRepository(apiProvider: ApiProvider());
      final List<dynamic>? result = await apiRepository.getTranslations();
      late final StorageService storageService = Get.find<StorageService>();
      if(result != null){
        await Future.wait(result.map((dynamic element) async{
          final LanguageImport languageImport = LanguageImport.fromJson(element as Map<String, dynamic>);

          // Ignore all languages path, not for mobile app
          if(languageImport.language != 'ALL'){
            String? currentMd5;
            String fileName;
            if(languageImport.language == 'EN'){
              currentMd5 = storageService.enLanguageMD5;
              fileName = 'en.json';
            }else if(languageImport.language == 'CN_SIMPLIFIED'){
              currentMd5 = storageService.cnLanguageMD5;
              fileName = 'zh.json';
            }else{
              currentMd5 = storageService.bmLanguageMD5;
              fileName = 'ms.json';
            }

            if(currentMd5 != languageImport.md5){
              final Map<String, dynamic> result = (await GetConnect().get(languageImport.path)) as Map<String, dynamic>;
              final String encodedData = jsonEncode(result);
              await writeJson(fileName, encodedData);
              writeMd5(languageImport);
            }
          }
        }));
      }
    }catch(e){
      print(e);
    }
    // End download translations from backend
    //////////////////////////////////////////////////////////////////////////////////////////////////////

    // Initialize translation file, either from downloaded file or from initial assets
    translations = await initializeI18n();
    print('initialize');
  }
  late Map<String, Map<String, String>> translations;

  @override
  Map<String, Map<String, String>> get keys =>
      translations;
}

/// Lines starting below is to support translation over-the-air
/// Download translation upon start of app and store it to local
/// This allow translation update immediately from backend
Future<String> get _localPath async {
  final Directory directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> getLocalFile(String fileName) async {
  final String path = await _localPath;
  return File('$path/$fileName');
}

Future<File> writeJson(String fileName, String body) async {
  final File file = await getLocalFile(fileName);
  // Write the file.
  return file.writeAsString(body);
}

void writeMd5(LanguageImport languageImport){
  late final StorageService storageService = Get.find<StorageService>();
  if(languageImport.language == 'EN'){
    storageService.setEnLanguageMD5(languageImport.md5);
  }else if(languageImport.language == 'CN_SIMPLIFIED'){
    storageService.setCnLanguageMD5(languageImport.md5);
  }else{
    storageService.setBmLanguageMD5(languageImport.md5);
  }
}