import 'dart:io';

class AdManager {

  static String get appId {
    if (Platform.isAndroid) {
      // return "ca-app-pub-5950215421046852~2139503986";
      return "";
    } else if (Platform.isIOS) {
      // return "ca-app-pub-5950215421046852~8700123349";
      return "";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      // return "ca-app-pub-5950215421046852/2812445499";
      return "";
    } else if (Platform.isIOS) {
      // return "ca-app-pub-5950215421046852/7734865345";
      return "";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      // return "ca-app-pub-5950215421046852/7762769598";
      return "";
    } else if (Platform.isIOS) {
      // return "ca-app-pub-5950215421046852/1707694800";
      return "";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      // return "ca-app-pub-5950215421046852/1702721412";
      return "";
    } else if (Platform.isIOS) {
      // return "ca-app-pub-5950215421046852/2773364468";
      return "";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}
