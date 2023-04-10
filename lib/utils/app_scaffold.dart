import 'package:flutter/material.dart';
import 'package:flutter_app_vibrator_strong/utils/touchable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/common/app_func.dart';
import '../core/assets/app_assets.dart';
import '../core/common/imagehelper.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/textstyles.dart';

class AppbarAction {
  final Widget widgetAction;
  final Function()? onPress;

  AppbarAction({required this.widgetAction, this.onPress});
}

class AppScaffold extends StatelessWidget {
  const AppScaffold(
      {Key? key,
      required this.body,
      this.title,
      this.isScroll = false,
      this.hideBackButton = false,
      this.onWillPop,
      this.padding,
      this.margin,
      this.safeArea = false,
      this.paddingTop,
      this.footer,
      this.titleView,
      this.titleStyle,
      this.hideAppBar = false,
      this.resizeToAvoidBottomInset,
      this.appBarHeight,
      this.actions,
      this.color,
      this.leading,
      this.drawer,
      this.customAppBar,
      this.scaffoldkey})
      : super(key: key);
  final Widget body;
  final String? title;
  final TextStyle? titleStyle;
  final Function()? onWillPop;
  final bool isScroll;
  final bool? hideBackButton;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool safeArea;
  final double? paddingTop;
  final Widget? footer;
  final Widget? titleView;
  final bool? hideAppBar;
  final bool? resizeToAvoidBottomInset;
  final List<AppbarAction>? actions;
  final Widget? leading;
  final Color? color;
  final double? appBarHeight;
  final Widget? drawer;
  final Widget? customAppBar;
  final GlobalKey<ScaffoldState>? scaffoldkey;

  _willPopCallback(BuildContext context) async {
    print("Get.previousRoute = ${Get.currentRoute}");
    onWillPop?.call();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _willPopCallback(context),
      child: Stack(
        children: [
          Positioned.fill(
            child: Scaffold(
              resizeToAvoidBottomInset: resizeToAvoidBottomInset,
              drawer: drawer,
              key: scaffoldkey,
              body: Container(
                padding: padding,
                color: color ?? Colors.white,
                child: SafeArea(
                  top: safeArea,
                  bottom: safeArea,
                  left: safeArea,
                  right: safeArea,
                  child: Column(
                    children: [
                      if (safeArea == false)
                        SizedBox(
                          height: paddingTop ?? 38.h,
                        ),
                      if (hideAppBar != true && customAppBar == null)
                        Container(
                          height: appBarHeight ?? AppBar().preferredSize.height,
                          color: color ?? Colors.white,
                          child: Stack(
                            children: [
                              if (hideBackButton != true)
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    height: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24),
                                    child: Touchable(
                                      onTap: () {
                                        Logger.debug('AppScaffold back click');
                                        _willPopCallback(context);
                                      },
                                      child: leading ??
                                          ImageHelper.loadFromAsset(
                                            AppAssets.icBack,
                                            width: 17,
                                            height: 17,
                                            tintColor: const Color(0xff505050),
                                          ),
                                    ),
                                  ),
                                ),
                              Align(
                                alignment: Alignment.center,
                                child: titleView ??
                                    Text(
                                      title ?? '',
                                      style:
                                          titleStyle ?? TextStyles.defaultStyle,
                                    ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 16.w),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: actions
                                            ?.map(
                                              (AppbarAction e) => Touchable(
                                                  onTap: e.onPress ?? () {},
                                                  child: e.widgetAction),
                                            )
                                            .toList() ??
                                        [],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      if (customAppBar != null)
                        customAppBar ?? const SizedBox(),
                      Expanded(
                          child: Container(
                        color: color ?? AppColors.customColor1,
                        child: body,
                      ))
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: footer ?? const SizedBox(),
          ),
        ],
      ),
    );
  }
}
