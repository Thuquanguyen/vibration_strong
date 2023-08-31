import 'package:flutter_app_vibrator_strong/applovin_manager.dart';
import 'package:flutter_app_vibrator_strong/core/base/base_controller.dart';
import 'package:get/get.dart';

import '../../core/model/language_model.dart';
import 'package:applovin_max/applovin_max.dart';

class LanguageController extends BaseController {
  RxList<LanguageModel> listLanguages = <LanguageModel>[
    LanguageModel(
        key: "en", name: "English", subName: "English", isChecked: true),
    LanguageModel(key: "ru", name: "Russian", subName: "Русский"),
    LanguageModel(key: "de", name: "German", subName: "Deutsch"),
    LanguageModel(key: "pt", name: "Portuguese", subName: "Português"),
    LanguageModel(key: "es", name: "Spanish", subName: "Española"),
    LanguageModel(key: "fr", name: "French", subName: "Français"),
    LanguageModel(key: "hi", name: "Hindi", subName: "हिंदी"),
    LanguageModel(key: "ko", name: "Korean", subName: "한국인"),
    LanguageModel(key: "ja", name: "Japanese", subName: "日本語"),
    LanguageModel(key: "mr", name: "Marathi", subName: "मराठी"),
    LanguageModel(key: "th", name: "Thailand", subName: "ประเทศไทย"),
    LanguageModel(key: "id", name: "Indonesian", subName: "bahasa Indonesia"),
  ].obs;
  Rx<MaxNativeAdViewController> nativeAdViewController =
      MaxNativeAdViewController().obs;
  static double kMediaViewAspectRatio = 16 / 9;

  RxString statusText = "".obs;

  RxDouble mediaViewAspectRatio = kMediaViewAspectRatio.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    nativeAdViewController.value.loadAd();
    super.onInit();
  }

  void changeLanguage(int index) {
    if (listLanguages[index].isChecked == true) {
      listLanguages[index].isChecked = false;
    } else {
      for (int i = 0; i < listLanguages.length; i++) {
        listLanguages[i].isChecked = false;
      }
      listLanguages[index].isChecked = true;
    }
    listLanguages.refresh();
  }
}
