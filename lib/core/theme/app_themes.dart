import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'app_colors.dart';

class AppThemes {
  final String sThemeModeKey = 'S_THEME_MODE_KEY';
  final String _sThemeModeLight = '_sThemeModeLight';
  final String _sThemeModeDark = '_sThemeModeDark';
  static String Poppins = "Poppins";
  static String Roboto = "Roboto";
  static String QuicksandRegular = "QuicksandRegular";
  static String QuicksandMedium = "QuicksandMedium";
  static String OpenSansRegular = "OpenSansRegular";

  static String _fontFamily = Roboto;

  // LIGHT THEME TEXT
  static final TextTheme _lightTextTheme = TextTheme(
    overline: TextStyle(color: AppColors.customColor23, fontFamily: _fontFamily),
    headline1: TextStyle(fontSize: 20.0, fontFamily: _fontFamily),
    bodyText1: TextStyle(fontSize: 16.0, fontFamily: _fontFamily),
    bodyText2: TextStyle(fontSize: 14.0, fontFamily: _fontFamily),
    button: TextStyle(fontSize: 15.0, fontFamily: _fontFamily),
    headline6: TextStyle(fontSize: 16.0, fontFamily: _fontFamily),
    subtitle1: TextStyle(fontSize: 16.0, fontFamily: _fontFamily),
    caption: TextStyle(fontSize: 12.0, fontFamily: _fontFamily),
  );

  // DARK THEME TEXT
  static final TextTheme _darkTextTheme = TextTheme(
    overline:
        TextStyle(color: AppColors.customColor25, fontFamily: _fontFamily),
    headline1: TextStyle(fontSize: 20.0, fontFamily: _fontFamily),
    bodyText1: TextStyle(fontSize: 16.0, fontFamily: _fontFamily),
    bodyText2: TextStyle(fontSize: 14.0, fontFamily: _fontFamily),
    button: TextStyle(fontSize: 15.0, fontFamily: _fontFamily),
    headline6: TextStyle(fontSize: 16.0, fontFamily: _fontFamily),
    subtitle1: TextStyle(fontSize: 16.0, fontFamily: _fontFamily),
    caption: TextStyle(fontSize: 12.0, fontFamily: _fontFamily),
  );

  // LIGHT THEME
  static final ThemeData _lightTheme = ThemeData(
      backgroundColor: Colors.white,
      fontFamily: _fontFamily,
      primaryColor: AppColors.customColor21,
      scaffoldBackgroundColor: AppColors.customColor20,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.customColor21,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Color(0XFF536A92),
        unselectedItemColor: Colors.red,
      ),
      bottomAppBarColor: Colors.white,
      appBarTheme: AppBarTheme(
        color: AppColors.customColor21,
        iconTheme: IconThemeData(color: AppColors.primaryColor1),
      ),
      colorScheme: ColorScheme.light(
        primary: AppColors.customColor21,
        primaryVariant: AppColors.customColor27,
      ),
      dividerTheme: DividerThemeData(color: AppColors.customColor23),
      snackBarTheme:
          SnackBarThemeData(backgroundColor: AppColors.customColor20),
      iconTheme: IconThemeData(
        color: AppColors.primaryColor1,
      ),
      popupMenuTheme:
          PopupMenuThemeData(color: AppColors.customColor20),
      textTheme: _lightTextTheme,
      cardColor: const Color(0XFFEE5A24),
      // canvasColor: Colors.black.withOpacity(0.1)
      canvasColor: Colors.black.withOpacity(0.1));

  // DARK THEME
  static final ThemeData _darkTheme = ThemeData(
      backgroundColor: const Color(0XFF252836),
      brightness: Brightness.dark,
      fontFamily: _fontFamily,
      primaryColor: AppColors.customColor21,
      scaffoldBackgroundColor: AppColors.customColor23,
      bottomAppBarColor: AppColors.customColor23,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.customColor21,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Color(0XFF536A92),
        unselectedItemColor: Colors.red,
      ),
      appBarTheme: AppBarTheme(
        color: AppColors.customColor21,
        iconTheme: IconThemeData(color: AppColors.customColor24),
      ),
      colorScheme: ColorScheme.dark(
        primary: AppColors.customColor21,
        primaryVariant: AppColors.customColor27,
      ),
      dividerTheme: DividerThemeData(color: AppColors.customColor20),
      snackBarTheme:
          SnackBarThemeData(backgroundColor: AppColors.customColor23),
      iconTheme: IconThemeData(
        color: AppColors.customColor24,
      ),
      popupMenuTheme: PopupMenuThemeData(color: AppColors.customColor23),
      textTheme: _darkTextTheme,
      canvasColor: Colors.white,
      cardColor: Colors.white
      // canvasColor:  Colors.white
      );

  /// LIGHT THEME
  static ThemeData theme() {
    return _lightTheme;
  }

  /// DARK THEME
  static ThemeData darkTheme() {
    return _darkTheme;
  }

  ///
  /// [AppThemes] initiation.
  /// Please Add [AppThemes().init() into GetMaterialApp.
  ///
  /// [Example] :
  ///
  /// GetMaterialApp(
  ///   themeMode: AppThemes().init(),
  /// )
  ///
  /// This [Function] works to initialize what theme is used.
  ThemeMode init() {
    final box = GetStorage();
    String? tm = box.read(sThemeModeKey);
    if (tm == null) {
      box.write(sThemeModeKey, _sThemeModeLight);
      return ThemeMode.light;
    } else if (tm == _sThemeModeLight) {
      return ThemeMode.light;
    } else {
      return ThemeMode.dark;
    }
  }

  void changeThemeMode(ThemeMode themeMode) {
    final box = GetStorage();
    if (themeMode == ThemeMode.dark) {
      box.write(sThemeModeKey, _sThemeModeDark);
    } else {
      box.write(sThemeModeKey, _sThemeModeLight);
    }
    // Get.changeThemeMode(themeMode);
    // Get.rootController.themeMode.reactive;
  }

  ///
  /// [ThemeData] general.
  ///
  /// [Example] :
  ///
  /// Text("Hello, world",
  ///   style: AppThemes().general().textTheme.bodyText1,
  /// )
  ///
  /// This [Function] is useful for styling widgets.
  ///
  /// [Function] AppThemes().general().*
  /// has several derivative functions.
  ThemeData general() {
    final box = GetStorage();
    String tm = box.read(sThemeModeKey) ?? _sThemeModeLight;
    if (tm == _sThemeModeLight) {
      return _lightTheme;
    }
    return _darkTheme;
  }
}
