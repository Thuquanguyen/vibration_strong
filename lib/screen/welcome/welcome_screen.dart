import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_vibrator_strong/core/common/imagehelper.dart';
import 'package:flutter_app_vibrator_strong/core/theme/textstyles.dart';
import 'package:flutter_app_vibrator_strong/routes/app_pages.dart';
import 'package:flutter_app_vibrator_strong/utils/app_scaffold.dart';
import 'package:flutter_app_vibrator_strong/utils/touchable.dart';
import 'package:flutter_app_vibrator_strong/widget/item_page.dart';
import 'package:get/get.dart';
import 'package:pageview_widget_indicator/pageview_widget_indicator.dart';
import '../../ad_manager.dart';
import '../../applovin_manager.dart';
import '../../core/assets/app_assets.dart';
import '../../language/i18n.g.dart';
import 'welcome_controller.dart';
import 'package:applovin_max/applovin_max.dart';

class WelcomeScreen extends GetView<WelcomeController> {
  WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarHeight: 0,
      hideAppBar: true,
      color: Colors.black54,
      body: Obx(() => Column(
            children: [
              Expanded(
                  flex: 6,
                  child: PageView.builder(
                    controller: controller.controller.value,
                    itemCount: 3,
                    onPageChanged: (pageIndex) {
                      controller.pageIndex.value = pageIndex;
                    },
                    itemBuilder: (context, index) => ItemPage(
                      title: controller.listTitle[index],
                      subTitle: controller.listSubTitle[index],
                      imgCover: "assets/images/banner_${index + 1}.jpeg",
                    ),
                  )),
              SizedBox(
                height: 10,
              ),
              Obx(() => Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black),
                    child: MaxNativeAdView(
                      adUnitId: AdManager.nativeAppAdUnitId,
                      controller: controller.nativeAdViewController.value,
                      listener: NativeAdListener(onAdLoadedCallback: (ad) {
                        ApplovinManager().logStatus(
                            'Native ad loaded from ${ad.networkName}');
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(4.0),
                                  child: const MaxNativeAdIconView(
                                    width: 48,
                                    height: 48,
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                            )),
                            MaxNativeAdCallToActionView(
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
                          ],
                        ),
                      ),
                    ),
                    padding: EdgeInsets.all(10),
                  ))),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Touchable(
                      onTap: () async {
                        bool isReady = (await AppLovinMAX.isInterstitialReady(
                            AdManager.interstitialAdUnitId))!;
                        print("show show show = $isReady");
                        if (isReady) {
                          AppLovinMAX.showInterstitial(
                              AdManager.interstitialAdUnitId);
                          Get.offAllNamed(Routes.MAIN);
                        } else {
                          AppLovinMAX.loadInterstitial(
                              AdManager.interstitialAdUnitId);
                        }
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.white, width: 1)),
                        child: Center(
                          child: Text(
                            I18n().skipStr.tr,
                            style: TextStyles.label1
                                .setColor(Colors.white)
                                .setHeight(1),
                          ),
                        ),
                      )),
                  Spacer(),
                  SizedBox(
                    width: 60,
                    height: 20,
                    child: PageViewIndicator(
                      height: 10,
                      builder: (context, index, isSelected) => Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 7),
                        decoration: BoxDecoration(
                          color:
                              Colors.white.withOpacity(isSelected ? 1.0 : 0.2),
                          borderRadius: BorderRadius.circular(20),
                          shape: BoxShape.rectangle,
                        ),
                      ),
                      pageController: controller.controller.value,
                      itemWidth: 20,
                      itemCount: 3,
                    ),
                  ),
                  Spacer(),
                  Obx(() => Touchable(
                      onTap: () async {
                        if (controller.pageIndex.value != 2) {
                          controller.controller.value.nextPage(
                              duration: Duration(milliseconds: 100),
                              curve: Curves.bounceIn);
                        } else {
                          bool isReady = (await AppLovinMAX.isInterstitialReady(
                              AdManager.interstitialAdUnitId))!;
                          print("show show show = $isReady");
                          if (isReady) {
                            AppLovinMAX.showInterstitial(
                                AdManager.interstitialAdUnitId);
                            Get.offAllNamed(Routes.MAIN);
                          } else {
                            AppLovinMAX.loadInterstitial(
                                AdManager.interstitialAdUnitId);
                          }
                        }
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.white, width: 1)),
                        child: Center(
                          child: Text(
                            controller.pageIndex.value != 2 ? I18n().nextStr.tr : I18n().doneStr.tr,
                            style: TextStyles.label1
                                .setColor(Colors.white)
                                .setHeight(1),
                          ),
                        ),
                      ))),
                  SizedBox(
                    width: 15,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              )
            ],
          )),
    );
  }
}
