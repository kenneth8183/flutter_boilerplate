import 'package:flutter_getx_boilerplate/shared/constants/constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService extends GetxService {
  static late SharedPreferences _preferences;
  static SharedPreferences get preferences => _preferences;

  Future<StorageService> init() async {
    _preferences = await SharedPreferences.getInstance();

    return this;
  }

  Future<void> setEnLanguageMD5(String md5) async {
    await _preferences.setString(StorageConstants.enLanguageMD5, md5);
  }

  String? get enLanguageMD5 =>
      _preferences.getString(StorageConstants.enLanguageMD5);

  Future<void> setCnLanguageMD5(String md5) async =>
      await _preferences.setString(StorageConstants.cnLanguageMD5, md5);

  String? get cnLanguageMD5 =>
      _preferences.getString(StorageConstants.cnLanguageMD5);

  Future<void> setBmLanguageMD5(String md5) async =>
      await _preferences.setString(StorageConstants.bmLanguageMD5, md5);

  String? get bmLanguageMD5 =>
      _preferences.getString(StorageConstants.bmLanguageMD5);

  Future<void> setLanguage(String langCode) async =>
      await _preferences.setString(StorageConstants.languageCode, langCode);

  String? get languageCode =>
      _preferences.getString(StorageConstants.languageCode);

  Future<void> setAccessToken(String accessToken) async =>
      await _preferences.setString(StorageConstants.accessToken, accessToken);

  String? get accessToken =>
      _preferences.getString(StorageConstants.accessToken);

  Future<void> setfcmToken(String fcmToken) async =>
      await _preferences.setString(StorageConstants.fcmToken, fcmToken);

  String? get fcmToken =>
      _preferences.getString(StorageConstants.fcmToken);
}
