import 'package:flutter/material.dart';

class CustomLinearProgressIndicator extends StatefulWidget {
  const CustomLinearProgressIndicator({
    Key? key,
    this.color = Colors.blue,
    this.backgroundColor = Colors.white,
    this.maxProgressWidth = 100,
  }) : super(key: key);

  /// max width in center progress
  final double maxProgressWidth;

  final Color color;
  final Color backgroundColor;

  @override
  State<CustomLinearProgressIndicator> createState() =>
      _CustomLinearProgressIndicatorState();
}

class _CustomLinearProgressIndicatorState
    extends State<CustomLinearProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 1))
        ..addListener(() {
          setState(() {});
        })
        ..repeat(reverse: true);

  late Animation animation =
      Tween<double>(begin: -1, end: 1).animate(controller);

  @override
  void dispose() {
    // TODO: implement dispose
    controller.stop();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: widget.backgroundColor,
      child: Align(
        alignment: Alignment(animation.value, 0),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          clipBehavior: Clip.hardEdge,
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: ShapeDecoration(
              color: widget.color,
              shape: const StadiumBorder(),
            ),
            // you can use animatedContainer, seems not needed
            width: widget.maxProgressWidth -
                widget.maxProgressWidth * (animation.value as double).abs(),
            height: double.infinity,
          ),
        ),
      ),
    );
  }
}
