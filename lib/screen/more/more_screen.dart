import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme/dimens.dart';
import '../../core/theme/textstyles.dart';
import '../../in_app_manage.dart';
import '../../routes/app_pages.dart';
import '../../utils/app_scaffold.dart';
import '../../widget/item_menu.dart';
import '../../widget/premium_widget.dart';
import 'more_controller.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MoreScreen extends GetView<MoreController> {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      safeArea: true,
      paddingTop: Dimens.topSafeAreaPadding,
      title: '',
      appBarHeight: 0,
      color: Colors.cyanAccent.withOpacity(0.05),
      titleStyle: TextStyles.title1,
      hideBackButton: true,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!IAPConnection().isAvailable) const PremiumWidget(),
            SizedBox(
              height: 30.h,
            ),
            Text(
              'Menu',
              style: TextStyles.body1.semiBold,
            ),
            SizedBox(
              height: 10.h,
            ),
            ...controller.vibrations.map((e) => ItemMenu(
              vibrationModel: e,
              moreController: controller,
            )),
            Spacer(),
            if (!IAPConnection().isAvailable)
              Obx(() => Visibility(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: controller.bannerAd.value.size.width.toDouble(),
                    height:
                    controller.bannerAd.value.size.height.toDouble(),
                    child: AdWidget(ad: controller.bannerAd.value),
                  ),
                ),
                visible: controller.isLoadAds.value,
              )),
          ],
        ),
      ),
    );
  }
}
