import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_getx_boilerplate/shared/shared.dart';
import 'package:get/get.dart';

import 'app_binding.dart';
import 'di.dart';
import 'lang/lang.dart';
import 'routes/routes.dart';
import 'theme/theme.dart';

class AppController extends GetxController {
  String? lastSelectedLanguageCode;
  String? fcmToken;

  // Required for starting app, only load crucial data require for app to start
  // Prevent heavy process because it happens before splash screen
  Future<void> _loadCrucialData() async {
    try {
      final StorageService storageService = Get.find<StorageService>();
      // final String? accessToken = storageService.accessToken;
      lastSelectedLanguageCode = storageService.languageCode;
      fcmToken = storageService.fcmToken;
      // For first time language loader, use device language.
      // If device language is not supported, use default language which should be en

      lastSelectedLanguageCode ??= Get.deviceLocale?.languageCode;
      if (!languages.contains(lastSelectedLanguageCode)) {
        lastSelectedLanguageCode = languages[0];
      }

      if(lastSelectedLanguageCode != null)
        storageService.setLanguage(lastSelectedLanguageCode!);

    } catch (e) {
      print(e);
    }
  }
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final AppController appController = Get.put(AppController());
  await DenpendencyInjection.init();
  await appController._loadCrucialData();

  final TranslationService translations = TranslationService();
  await translations.init();

  runApp(App(translations));
  configLoading();
}

class App extends StatelessWidget {
  App(this.translationService){
    appController = Get.find<AppController>();
    languageCode = appController.lastSelectedLanguageCode != null
        ? appController.lastSelectedLanguageCode!
        : languages.first;
  }
  late final AppController appController;
  late final String languageCode;
  late final TranslationService translationService;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      enableLog: true,
      initialRoute: Routes.SPLASH,
      defaultTransition: Transition.fade,
      getPages: AppPages.routes,
      initialBinding: AppBinding(),
      smartManagement: SmartManagement.keepFactory,
      title: 'Flutter GetX Boilerplate',
      theme: lightTheme,
      locale: Locale(languageCode),
      fallbackLocale: TranslationService.fallbackLocale,
      translations: translationService,
      builder: EasyLoading.init(),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.threeBounce
    ..loadingStyle = EasyLoadingStyle.custom
    // ..indicatorSize = 45.0
    ..radius = 10.0
    // ..progressColor = Colors.yellow
    ..backgroundColor = lightGray
    ..indicatorColor = hexToColor('#64DEE0')
    ..textColor = hexToColor('#64DEE0')
    // ..maskColor = Colors.red
    ..userInteractions = false
    ..dismissOnTap = false
    ..animationStyle = EasyLoadingAnimationStyle.scale;
}
