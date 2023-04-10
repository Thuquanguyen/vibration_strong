import 'package:flutter/material.dart';
import 'package:flutter_app_vibrator_strong/router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Ads/ad_manager.dart';
import 'Splat/splat_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static void restartApp(BuildContext context, String key, {String? fontStyle, Color? color}) {
    context
        .findAncestorStateOfType<_MyAppState>()
        ?.resetFont(key, fontStyle: fontStyle ?? null, color: color ?? Colors.white);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var font = GoogleFonts.roboto().fontFamily;
  Color backgroundMode = Colors.white;
  Color textColor = Colors.black;

  Future<InitializationStatus> _initGoogleMobileAds() {
    return MobileAds.instance.initialize();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNamePreference("fonts");
    getNamePreference("background");
    getNamePreference("textcolor");
    _initGoogleMobileAds();
  }

  void resetFont(String key, {String? fontStyle,Color? color}) {
    saveNamePreference(key, font: fontStyle, color: color);
    getNamePreference(key);
  }

  saveNamePreference(String key, {String? font, Color? color}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (font == null) {
        prefs.setInt(key, color?.value ?? 0);
      } else {
        prefs.setString(key, font);
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  getNamePreference(String key) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        switch (key) {
          case "fonts":
            String? value = prefs.getString(key);
            font = value;
            break;
          case "background":
            int? color = prefs.getInt(key) ?? 0;
            backgroundMode = color == 0 ? Colors.white : Color(color);
            break;
          case "textcolor":
            int? color = prefs.getInt(key) ?? 0;
            textColor = color == 0 ? Colors.black : Color(color);
            break;
          default:
            break;
        }
      });
      return true;
    } catch (e) {
      print(e);
      setState(() {
        font = GoogleFonts.roboto().fontFamily;
      });
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
            fontFamily: font,
            scaffoldBackgroundColor: backgroundMode,
            textTheme: Theme.of(context)
                .textTheme
                .apply(bodyColor: textColor, displayColor: textColor, decorationColor: textColor)),
        initialRoute: SplatView.routeName,
        onGenerateRoute: Routerr.generateRoute,
        routes: {});
  }
}
