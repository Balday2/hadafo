import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Wbutton extends StatelessWidget {
  final Widget child;
  final Function onPressed;
  final double? elevation;
  final double? shape;
  final Color? outlineColor;
  final Color? shadow;
  final Color? color;
  final Color? overColor;
  final double? width;
  final double? height;
  final double? paddingAll;

  const Wbutton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.elevation = 5.0,
    this.shape = 12.0,
    this.outlineColor = Colors.transparent,
    this.shadow = Colors.transparent,
    this.color = Colors.blueAccent,
    this.overColor = Colors.black,
    this.width = 200.0,
    this.height = 55.0,
    this.paddingAll = 20.0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(paddingAll!),
      child: ElevatedButton(
        onPressed: (){onPressed();},
        style: ButtonStyle(
          animationDuration: 200.milliseconds,
          enableFeedback: true,
          backgroundColor: MaterialStateProperty.all(color),
          elevation: MaterialStateProperty.all(elevation),
          minimumSize: MaterialStateProperty.all(Size(width!, height!)),
          overlayColor: MaterialStateProperty.all(overColor!.withOpacity(0.3)),
          shadowColor: MaterialStateProperty.all(shadow),
          visualDensity: VisualDensity.comfortable,
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(shape!),
            side: BorderSide(width: 1.0, color: outlineColor!),
          )),
        ),
        child: child,
      ),
    );
  }
}
