import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/textstyles.dart';

int lastClickTime = DateTime.now().millisecondsSinceEpoch - 1000;
const int timeDoubleClick = 700;

class Touchable extends StatelessWidget {
  final Function() onTap;
  final Function()? onLongPress;
  final Function(TapDownDetails)? onTapDown;
  final Widget child;
  final bool rippleAnimation;
  final bool enableFeedback;
  final Color? rippleColor;

  const Touchable(
      {Key? key,
      required this.onTap,
      required this.child,
      this.onTapDown,
      this.onLongPress,
      this.enableFeedback = false,
      this.rippleAnimation = false,
      this.rippleColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (rippleAnimation) {
      return TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          shadowColor: Colors.transparent,
          primary: rippleColor ?? AppColors.customColor1,
          elevation: 0,
          enableFeedback: enableFeedback,
          backgroundColor: Colors.transparent,
          textStyle: TextStyles.defaultStyle,
          splashFactory: InkRipple.splashFactory,
          // animationDuration: const Duration(milliseconds: 3000),
        ),
        onLongPress: onLongPress,
        onPressed: onTap,
        child: Container(
          color: Colors.transparent,
          child: child,
        ),
      );
    } else {
      return GestureDetector(
          onTap: onTap,
          onTapDown: onTapDown,
          onLongPress: onLongPress,
          child: Container(
            color: Colors.transparent,
            child: child,
          ));
    }
  }

  void onPossyPressed() {
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    if (currentTime - lastClickTime >= timeDoubleClick) {
      lastClickTime = currentTime;
      onTap.call();
    }
  }
}
