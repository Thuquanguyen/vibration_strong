import 'package:flutter/material.dart';
import '../../core/theme/textstyles.dart';
import '../core/assets/app_assets.dart';
import '../core/common/imagehelper.dart';
import '../language/i18n.g.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyBlinkingButton extends StatefulWidget {
  const MyBlinkingButton({key,this.urlHelp});
  final String? urlHelp;
  @override
  _MyBlinkingButtonState createState() => _MyBlinkingButtonState();
}

class _MyBlinkingButtonState extends State<MyBlinkingButton>
    with SingleTickerProviderStateMixin {
  late Animation animation;
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    final CurvedAnimation curve =
    CurvedAnimation(parent: controller, curve: Curves.linear);
    animation =
        ColorTween(begin: Colors.greenAccent, end: Colors.red).animate(curve);
    // Keep the animation going forever once it is started
    animation.addStatusListener((status) {
      // Reverse the animation after it has been completed
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
      setState(() {});
    });
    // Remove this line if you want to start the animation later
    controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child){
          return Container(
            decoration: BoxDecoration(
                color: animation.value,
                borderRadius: BorderRadius.circular(20)
            ),
            padding: EdgeInsets.all(5.w),
            child: Row(
              children: [
                Text(I18n().unlockPremiumStr.tr,style: TextStyles.caption.setHeight(1.4).setColor(Colors.white),),
                SizedBox(width: 5,),
                ImageHelper.loadFromAsset(AppAssets.icPremium,
                    width: 15, height: 15, tintColor: Colors.lime)
              ],
            ),
          );
        }
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}