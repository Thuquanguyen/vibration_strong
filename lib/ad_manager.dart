import 'dart:io';

class AdManager {

  static final AdManager _singleton = AdManager._internal();

  factory AdManager() {
    return _singleton;
  }

  AdManager._internal();

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3813752684589876/2457353042';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3813752684589876/8831189709";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/4411468910";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3813752684589876/5116657045";
    } else if (Platform.isIOS) {
      return "ca-app-pub-8786339512646303/4817372869";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get openAppAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3813752684589876/6205026361";
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
