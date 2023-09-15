import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/model/vibration_model.dart';
import '../core/theme/textstyles.dart';
import '../vibrator_manage.dart';
import '../screen/more/more_controller.dart';
import '../utils/touchable.dart';

class ItemMenu extends StatelessWidget {
  ItemMenu({Key? key, this.vibrationModel, this.moreController})
      : super(key: key);
  VibrationModel? vibrationModel;
  MoreController? moreController;

  @override
  Widget build(BuildContext context) {
    return Touchable(
      onTap: () {
        vibrationModel?.onTap?.call();
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16.r)),
        margin: EdgeInsets.symmetric(vertical: 5.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.pinkAccent.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(16.r)),
              padding: EdgeInsets.all(6.w),
              child: Center(
                child: Icon(
                  vibrationModel?.iconData ?? Icons.info_outline,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
            SizedBox(
              width: 15.w,
            ),
            Expanded(
                child: Text(
                  vibrationModel?.title ?? '',
                  style: TextStyles.defaultStyle,
                )),
            const Icon(
              Icons.navigate_next,
              color: Colors.black26,
            )
          ],
        ),
      ),
    );
  }
}
