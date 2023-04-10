import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/alert_doc.dart';
import '../../utils/app_loading.dart';
import '../../utils/touchable.dart';
import '../theme/app_colors.dart';
import '../theme/textstyles.dart';
import 'imagehelper.dart';
import 'write_log_helper.dart';

part 'logger_func.dart';

class AppFunc {
  static final logger = Logger();
  static StreamSubscription? showLoadingTimeout;

  static Timer setInterval(Function callback, int milliseconds) {
    return Timer.periodic(Duration(milliseconds: milliseconds), (timer) {
      callback();
    });
  }

  static void clearInterval(Timer subscription) {
    try {
      subscription.cancel();
    } catch (e) {
      Logger.debug(e);
    }
  }

  static StreamSubscription setTimeout(Function callback, int milliseconds) {
    final future = Future.delayed(Duration(milliseconds: milliseconds));
    return future.asStream().listen((event) {}, onDone: () {
      callback();
    });
  }

  static void clearTimeout(StreamSubscription subscription) {
    try {
      subscription.cancel();
    } catch (e) {
      Logger.debug(e.toString());
    }
  }

  static String getLetterAvatar(String name) {
    final tmp = name.split(' ');
    if (tmp.length >= 2) {
      String tmp1 = tmp[0];
      String tmp2 = tmp[tmp.length - 1];
      return '${tmp1[0]}${tmp2[0]}'.toUpperCase();
    } else if (name.length > 1) {
      return '${name[0]}${name[1]}'.toUpperCase();
    } else {
      return name.toUpperCase();
    }
  }

  static void hideKeyboard(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  //Loading
  static const _bg1 =
      Colors.black54; //Color.fromRGBO(5,166,88, 1.0); //Colors.green
  static const _bg2 = Color.fromRGBO(255, 0, 0, 0.6);

  static void initLoadingStyle() {
    EasyLoading.instance
      // ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.custom
      // ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.white
      ..backgroundColor = _bg1
      ..indicatorColor = Colors.white
      ..textColor = Colors.white
      ..maskColor = Colors.blue.withOpacity(0.5)
      // ..userInteractions = false
      // ..dismissOnTap = false
      ..animationStyle = EasyLoadingAnimationStyle.opacity
      // ..indicatorWidget = ImageHelper.loadAsset(AssetHelper.imgVPBankSplashLogo, width: 60, height: 40, fit: BoxFit.contain)
      ..customAnimation = CustomAnimation();
  }

  static bool emailValid(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  static showAlertDialog(BuildContext context,
      {String? message, String? title}) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OKay!",style: TextStyles.defaultStyle,),
      onPressed: () {
        Get.back();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title ?? "Notification"),
      content: Text(message ?? ''),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showAlertDialogConfirm(
    BuildContext context, {
    String? message,
    Function()? callBack,
    Function()? cancelCallback,
  }) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("同意"),
      onPressed: callBack,
    );

    // set up the button
    Widget cancelButton = TextButton(
      child: const Text("キャンセル"),
      onPressed: () {
        Get.back();
        cancelCallback?.call();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("通知する!"),
      content: Text(message ?? ''),
      actions: [okButton, cancelButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showAlertDialogLogout(
    BuildContext context, {
    String? message,
    Function()? callBack,
  }) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("同意"),
      onPressed: callBack,
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("通知する!"),
      content: Text(message ?? ''),
      actions: [okButton],
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static Future<bool> openBrowser(String url) async {
    if (Platform.isIOS) {
      if (await canLaunch(url)) {
        await launch(url);
        return true;
      } else {
        print('Could not launch $url');
      }
    }
    if (await canLaunch(url)) {
      await launch(url);
      return true;
    } else {
      try {
        await launch(url);
        return true;
      } catch (e) {
        print('Could not launch $url');
      }
    }
    return false;
  }

  static void showLoading({
    String? status,
    Widget? indicator,
    bool? dismissOnTap,
    EasyLoadingMaskType? maskType = EasyLoadingMaskType.clear,
  }) {
    if (EasyLoading.isShow) {
      return;
    }
    EasyLoading.instance.backgroundColor = _bg1;
    EasyLoading.show(
        status: status,
        indicator: indicator,
        dismissOnTap: dismissOnTap,
        maskType: maskType);
    if (showLoadingTimeout != null) {
      clearTimeout(showLoadingTimeout!);
      showLoadingTimeout = null;
    }
    showLoadingTimeout = setTimeout(() {
      hideLoading();
    }, 40000);
  }

  static void hideLoading() {
    if (showLoadingTimeout != null) {
      clearTimeout(showLoadingTimeout!);
      showLoadingTimeout = null;
    }
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
  }

  static void showSuccess(
    String status, {
    Duration? duration,
    bool? dismissOnTap,
  }) {
    EasyLoading.instance.backgroundColor = _bg1;
    EasyLoading.showSuccess(status,
        duration: duration,
        dismissOnTap: dismissOnTap,
        maskType: EasyLoadingMaskType.clear);
  }

  static void showError(
    String status, {
    Duration? duration,
    bool? dismissOnTap,
  }) {
    EasyLoading.instance.backgroundColor = _bg2;
    EasyLoading.showError(status,
        duration: duration,
        dismissOnTap: dismissOnTap,
        maskType: EasyLoadingMaskType.clear);
  }

  static void showInfo(
    String status, {
    Duration? duration,
    bool? dismissOnTap,
  }) {
    EasyLoading.showInfo(status,
        duration: duration,
        dismissOnTap: dismissOnTap,
        maskType: EasyLoadingMaskType.clear);
  }

  static void showToast(String message) {
    EasyLoading.showToast(message);
  }

  static void showProgress(
    double value, {
    String? status,
  }) {
    EasyLoading.instance.backgroundColor = Colors.green;
    EasyLoading.showProgress(value,
        status: status, maskType: EasyLoadingMaskType.clear);
  }

  // static IOSAuthMessages getIOSAuthMessages(BiometricType biometricType) {
  //   return IOSAuthMessages(
  //     cancelButton: 'Hủy',
  //     goToSettingsButton: 'Cài đặt',
  //     goToSettingsDescription: biometricType == BiometricType.face
  //         ? 'Vui lòng cài đặt xác thực Face ID'
  //         : 'Vui lòng cài đặt xác thực Touch ID',
  //     lockOut: 'Bạn đã quá số lần thử',
  //   );
  // }
  //
  // static AndroidAuthMessages getAndroidAuthMessages(
  //     BiometricType biometricType) {
  //   return const AndroidAuthMessages(
  //     cancelButton: 'Hủy',
  //     goToSettingsButton: 'Cài đặt',
  //     goToSettingsDescription: 'Vui lòng cài đặt vân tay để sử dụng xác thực',
  //   );
  // }

  static String joinName(List<String?>? listData) {
    String name = '';
    for (int i = 0; i < (listData?.length ?? 0); i++) {
      String? element = listData?[i];
      if (element?.isNotEmpty ?? false) {
        name += (element ?? '') +
            ((i != ((listData?.length ?? 0) - 1)) ? ' - ' : '');
      }
    }
    listData?.forEach((element) {});
    return name;
  }

  static Future<void> waitForContext(
      Function(BuildContext context) callback) async {
    // int dem = 0;
    // while (true) {
    //   if (SessionManager().getContext != null) {
    //     callback.call(SessionManager().getContext!);
    //     break;
    //   }
    //   if (dem >= 30) {
    //     break;
    //   }
    //   dem++;
    //   await Future.delayed(const Duration(milliseconds: 500));
    // }
  }

  showAlert(BuildContext context,
      {String? icon,
      String? title,
      String? message,
      String? titleLeft,
      TextStyle? styleTitleLeft,
      TextStyle? styleTitleRight,
      String? titleRight,
      Function? actionLeft,
      Color? colorRight,
      Function? actionRight}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDoc(
        icon:
            ImageHelper.loadFromAsset(icon ?? '', width: 117.w, height: 117.w),
        title: title,
        message: message ?? '',
        actions: Row(
          children: [
            Expanded(
              child: Touchable(
                onTap: () {
                  if (actionLeft != null) {
                    actionLeft.call();
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.neutralColor7,
                      borderRadius: BorderRadius.circular(8.r)),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  child: Center(
                    child: Text(
                      titleLeft ?? ''.toUpperCase(),
                      style: styleTitleLeft ?? TextStyles.body1,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 13.w,
            ),
            Expanded(
              child: Touchable(
                onTap: () {
                  actionRight?.call();
                },
                child: Container(
                  decoration: colorRight != null
                      ? BoxDecoration(
                          color: AppColors.statusColor2,
                          borderRadius: BorderRadius.circular(8.r))
                      : BoxDecoration(
                          gradient: LinearGradient(
                            begin: FractionalOffset.topCenter,
                            end: FractionalOffset.bottomCenter,
                            colors: AppColors.linearPrimary1,
                            stops: const [0.0, 1.0],
                          ),
                          borderRadius: BorderRadius.circular(8.r)),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  child: Center(
                    child: Text(
                      titleRight ?? ''.toUpperCase(),
                      style: styleTitleRight ??
                          TextStyles.body1.setColor(titleRight == null
                              ? AppColors.primaryColor2
                              : Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
