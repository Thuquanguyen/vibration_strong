import 'dart:io';

class AdManager {

  static final AdManager _singleton = AdManager._internal();

  factory AdManager() {
    return _singleton;
  }

  AdManager._internal();

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-1244158433596230/5269512357';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-1244158433596230/4590855508";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/4411468910";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-1244158433596230/3166093195";
    } else if (Platform.isIOS) {
      return "ca-app-pub-8786339512646303/4817372869";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get openAppAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-1244158433596230/8801563252";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/1712485313";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

// static String get bannerAdUnitId {
//   if (Platform.isAndroid) {
//     return 'ca-app-pub-3940256099942544/6300978111';
//   } else if (Platform.isIOS) {
//     return 'ca-app-pub-3940256099942544/2934735716';
//   } else {
//     throw new UnsupportedError('Unsupported platform');
//   }
// }
//
// static String get interstitialAdUnitId {
//   if (Platform.isAndroid) {
//     return "ca-app-pub-3940256099942544/1033173712";
//   } else if (Platform.isIOS) {
//     return "ca-app-pub-3940256099942544/4411468910";
//   } else {
//     throw new UnsupportedError("Unsupported platform");
//   }
// }
//
// static String get rewardedAdUnitId {
//   if (Platform.isAndroid) {
//     return "ca-app-pub-3940256099942544/5224354917";
//   } else if (Platform.isIOS) {
//     return "ca-app-pub-3940256099942544/1712485313";
//   } else {
//     throw new UnsupportedError("Unsupported platform");
//   }
// }
//
//   static String get openAppAdUnitId {
//     if (Platform.isAndroid) {
//       return "ca-app-pub-3940256099942544/3419835294";
//     } else if (Platform.isIOS) {
//       return "ca-app-pub-3940256099942544/1712485313";
//     } else {
//       throw new UnsupportedError("Unsupported platform");
//     }
//   }
}
