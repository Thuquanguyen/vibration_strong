import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/theme/textstyles.dart';

class AlertDoc extends StatelessWidget {
  const AlertDoc({
    this.icon,
    this.title,
    this.message,
    this.actions,
    Key? key,
  }) : super(key: key);

  final Widget? icon;
  final String? title;
  final String? message;
  final Widget? actions;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.r),
      ),
      title: title == null
          ? null
          : Text(
              title!,
              textAlign: TextAlign.center,
            ),
      titleTextStyle: TextStyles.defaultStyle,
      content: message == null
          ? null
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 39.h,
                ),
                icon!,
                SizedBox(
                  height: 26.h,
                ),
                Text(
                  message!,
                  textAlign: TextAlign.center,
                  style: TextStyles.defaultStyle,
                ),
                SizedBox(
                  height: 25.h,
                ),
                actions!
              ],
            ),
    );
  }
}
