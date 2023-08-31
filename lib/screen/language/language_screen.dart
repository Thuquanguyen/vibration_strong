import 'package:flutter/material.dart';
import 'package:flutter_app_vibrator_strong/ad_manager.dart';
import 'package:flutter_app_vibrator_strong/applovin_manager.dart';
import 'package:flutter_app_vibrator_strong/core/theme/app_colors.dart';
import 'package:flutter_app_vibrator_strong/core/theme/textstyles.dart';
import 'package:flutter_app_vibrator_strong/language/i18n.g.dart';
import 'package:flutter_app_vibrator_strong/routes/app_pages.dart';
import 'package:flutter_app_vibrator_strong/utils/app_scaffold.dart';
import 'package:flutter_app_vibrator_strong/utils/touchable.dart';
import 'package:flutter_app_vibrator_strong/widget/item_language.dart';
import 'package:get/get.dart';

import '../../core/theme/dimens.dart';
import 'language_controller.dart';
import 'package:applovin_max/applovin_max.dart';

class LanguageScreen extends GetView<LanguageController> {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      hideAppBar: true,
      appBarHeight: 0,
      color: AppColors.customColor30,
      hideBackButton: true,
      body: Container(
        margin: EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Column(
          children: [
            SizedBox(
              height: Dimens.topSafeAreaPadding - 5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text(
                    I18n().selectLanguageStr.tr,
                    style: TextStyles.title2.setColor(Colors.white),
                  )),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Touchable(
                        onTap: () {
                          Get.toNamed(Routes.WELCOME);
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              I18n().doneStr.tr.toUpperCase(),
                              style: TextStyles.body3.setColor(Colors.white),
                            )
                          ],
                        )),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: Obx(() => ListView.builder(
                      padding: EdgeInsets.zero,
                      itemBuilder: (ctx, index) => ItemLanguage(
                        index: index,
                        languageModel: controller.listLanguages.value[index],
                        controller: controller,
                      ),
                      itemCount: controller.listLanguages.length,
                    ))),
            SizedBox(
              height: 10,
            ),
            Obx(() => Container(
                  margin: const EdgeInsets.all(8.0),
                  height: 200,
                  child: MaxNativeAdView(
                    adUnitId: AdManager.nativeAppAdUnitId,
                    controller: controller.nativeAdViewController.value,
                    listener: NativeAdListener(onAdLoadedCallback: (ad) {
                      ApplovinManager()
                          .logStatus('Native ad loaded from ${ad.networkName}');
                      controller.mediaViewAspectRatio.value =
                          ad.nativeAd?.mediaContentAspectRatio ?? 16 / 9;
                    }, onAdLoadFailedCallback: (adUnitId, error) {
                      ApplovinManager().logStatus(
                          'Native ad failed to load with error code ${error.code} and message: ${error.message}');
                    }, onAdClickedCallback: (ad) {
                      ApplovinManager().logStatus('Native ad clicked');
                    }, onAdRevenuePaidCallback: (ad) {
                      ApplovinManager()
                          .logStatus('Native ad revenue paid: ${ad.revenue}');
                    }),
                    child: Container(
                      color: const Color(0xffefefef),
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(4.0),
                                child: const MaxNativeAdIconView(
                                  width: 48,
                                  height: 48,
                                ),
                              ),
                              const Flexible(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MaxNativeAdTitleView(
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                      maxLines: 1,
                                      overflow: TextOverflow.visible,
                                    ),
                                    MaxNativeAdAdvertiserView(
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 10),
                                      maxLines: 1,
                                      overflow: TextOverflow.fade,
                                    ),
                                    MaxNativeAdStarRatingView(
                                      size: 10,
                                    ),
                                  ],
                                ),
                              ),
                              const MaxNativeAdOptionsView(
                                width: 20,
                                height: 20,
                              ),
                            ],
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: MaxNativeAdBodyView(
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: AspectRatio(
                              aspectRatio:
                                  controller.mediaViewAspectRatio.value,
                              child: const MaxNativeAdMediaView(),
                            ),
                          ),
                          const SizedBox(
                            width: double.infinity,
                            child: MaxNativeAdCallToActionView(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Color(0xff2d545e)),
                                textStyle: MaterialStatePropertyAll<TextStyle>(
                                    TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
