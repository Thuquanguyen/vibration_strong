import 'dart:io';

class AdManager {

  static final AdManager _singleton = AdManager._internal();

  factory AdManager() {
    return _singleton;
  }

  AdManager._internal();

  static String get bannerAdUnitId {
  if (Platform.isAndroid) {
    return 'ca-app-pub-9184134236196103/2693985710';
  } else if (Platform.isIOS) {
    return 'ca-app-pub-3940256099942544/2934735716';
  } else {
    throw new UnsupportedError('Unsupported platform');
  }
}

static String get interstitialAdUnitId {
  if (Platform.isAndroid) {
    return "ca-app-pub-9184134236196103/6441659034";
  } else if (Platform.isIOS) {
    return "ca-app-pub-3940256099942544/4411468910";
  } else {
    throw new UnsupportedError("Unsupported platform");
  }
}

static String get rewardedAdUnitId {
  if (Platform.isAndroid) {
    return "ca-app-pub-9184134236196103/4500486435";
  } else if (Platform.isIOS) {
    return "ca-app-pub-3940256099942544/1712485313";
  } else {
    throw new UnsupportedError("Unsupported platform");
  }
}

  static String get nativeAppAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-9184134236196103/2338477084";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/1712485313";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get openAppAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-9184134236196103/9822500844";
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
//   static String get nativeAppAdUnitId {
//     if (Platform.isAndroid) {
//       return "ca-app-pub-3940256099942544/2247696110";
//     } else if (Platform.isIOS) {
//       return "ca-app-pub-3940256099942544/1712485313";
//     } else {
//       throw new UnsupportedError("Unsupported platform");
//     }
//   }
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
