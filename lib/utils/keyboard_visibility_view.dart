import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../core/common/app_func.dart';
import '../core/common/message_handler.dart';
import 'lazy_widget.dart';
import 'touchable.dart';

const INPUT_TYPE_CHANGE = 'INPUT_TYPE_CHANGE';

class InputDoneView extends StatelessWidget {
  const InputDoneView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(255, 255, 255, 0.8),
      width: double.infinity,
      child: Align(
        alignment: Alignment.topRight,
        child: Touchable(
          onTap: () {
            AppFunc.hideKeyboard(context);
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Text(
              'DONE',
              // AppTranslate.i18n.titleDoneStr.localized.toUpperCase(),
              // style: TextStyles.itemText.setFontWeight(FontWeight.bold).setColor(AppColors.gPrimaryColor),
            ),
          ),
        ),
      ),
    );
  }
}

class KeyboardVisibilityView extends StatefulWidget {
  const KeyboardVisibilityView({Key? key}) : super(key: key);
  static TextInputType? _currentInputType;

  static void setCurrentInputType(TextInputType inputType) {
    print('change input type');
    if (_currentInputType != inputType) {
      _currentInputType = inputType;
      MessageHandler().notify(INPUT_TYPE_CHANGE);
    }
  }

  @override
  _KeyboardVisibilityState createState() => _KeyboardVisibilityState();
}

class _KeyboardVisibilityState extends State<KeyboardVisibilityView> {
  var keyboardVisibilityController = KeyboardVisibilityController();
  late StreamSubscription<bool> keyboardSubscription;
  bool _isShowDone = false;
  bool _isShowKeyboard = false;

  void handleChangeInputType() {
    if (_isShowKeyboard) {
      setState(() {
        if (KeyboardVisibilityView._currentInputType == TextInputType.number ||
            KeyboardVisibilityView._currentInputType == TextInputType.phone) {
          _isShowDone = true;
        } else {
          _isShowDone = false;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    MessageHandler().addListener(INPUT_TYPE_CHANGE, handleChangeInputType);
    // Subscribe
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      print('Keyboard visibility update. Is visible: $visible');
      setState(() {
        _isShowKeyboard = visible;
        if (_isShowDone == false &&
            (KeyboardVisibilityView._currentInputType == TextInputType.number ||
                KeyboardVisibilityView._currentInputType ==
                    TextInputType.phone)) {
          _isShowDone = true;
        } else if (_isShowDone == true) {
          _isShowDone = false;
          KeyboardVisibilityView._currentInputType = null;
        }
      });
      // }
    });
  }

  @override
  void dispose() {
    keyboardSubscription.cancel();
    MessageHandler().removeListener(INPUT_TYPE_CHANGE, handleChangeInputType);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isShowDone
        ? LazyWidget(
            delay: 200,
            child: Positioned(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                right: 0.0,
                left: 0.0,
                child: const InputDoneView()),
          )
        : const SizedBox();
  }
}
