
import '../theme/dimens.dart';

const double screenWidthInDesign = 375.0;
const double screenHeightInDesign = 812.0;

extension ExtendedNumber on num {
  double get toScreenSize {
    return (this / screenWidthInDesign) * Dimens.screenWidth;
  }

  double get toScreenWidthHeight {
    double designRatio =
        screenWidthInDesign / screenHeightInDesign; // iphone 12 pro max
    return (this * designRatio) / Dimens.sizeRatio;
  }

  bool get isInt => (this % 1) == 0;
}
