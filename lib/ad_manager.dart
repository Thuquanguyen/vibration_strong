import 'dart:io';

class AdManager {

  static final AdManager _singleton = AdManager._internal();

  factory AdManager() {
    return _singleton;
  }

  AdManager._internal();

  // static String get bannerAdUnitId {
  //   if (Platform.isAndroid) {
  //     return 'ca-app-pub-8724493546060841/9206334463';
  //   } else if (Platform.isIOS) {
  //     return 'ca-app-pub-3940256099942544/2934735716';
  //   } else {
  //     throw new UnsupportedError('Unsupported platform');
  //   }
  // }
  //
  // static String get interstitialAdUnitId {
  //   if (Platform.isAndroid) {
  //     return "ca-app-pub-8724493546060841/1164763732";
  //   } else if (Platform.isIOS) {
  //     return "ca-app-pub-3940256099942544/4411468910";
  //   } else {
  //     throw new UnsupportedError("Unsupported platform");
  //   }
  // }
  //
  // static String get rewardedAdUnitId {
  //   if (Platform.isAndroid) {
  //     return "ca-app-pub-8724493546060841/4156106192";
  //   } else if (Platform.isIOS) {
  //     return "ca-app-pub-8786339512646303/4817372869";
  //   } else {
  //     throw new UnsupportedError("Unsupported platform");
  //   }
  // }
  //
  // static String get openAppAdUnitId {
  //   if (Platform.isAndroid) {
  //     return "ca-app-pub-8724493546060841/2308672050";
  //   } else if (Platform.isIOS) {
  //     return "ca-app-pub-3940256099942544/1712485313";
  //   } else {
  //     throw new UnsupportedError("Unsupported platform");
  //   }
  // }

  static String get sdkKey {
    return "hSsRnQ4Zzz5gbaWTKEftwpHxlJucNOpkZeBvEPnogcgWAAB9ERVIFHNG_WHhJTkHCh5AyFcRTF6kN711_nKE3d";
  }

static String get bannerAdUnitId {
  if (Platform.isAndroid) {
    return 'e0d6187dae230362';
  } else if (Platform.isIOS) {
    return 'ca-app-pub-3940256099942544/2934735716';
  } else {
    throw new UnsupportedError('Unsupported platform');
  }
}

static String get interstitialAdUnitId {
  if (Platform.isAndroid) {
    return "78a669d8a286be73";
  } else if (Platform.isIOS) {
    return "ca-app-pub-3940256099942544/4411468910";
  } else {
    throw new UnsupportedError("Unsupported platform");
  }
}

static String get rewardedAdUnitId {
  if (Platform.isAndroid) {
    return "b4802f265f352ed8";
  } else if (Platform.isIOS) {
    return "ca-app-pub-3940256099942544/1712485313";
  } else {
    throw new UnsupportedError("Unsupported platform");
  }
}

  static String get openAppAdUnitId {
    if (Platform.isAndroid) {
      return "672552471047e0c2";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/1712485313";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get nativeAppAdUnitId {
    if (Platform.isAndroid) {
      return "d3724d89339cddef";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/1712485313";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
  static String get nativeAppSmallAdUnitId {
    if (Platform.isAndroid) {
      return "69b38b24dbd2afa3";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/1712485313";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}
