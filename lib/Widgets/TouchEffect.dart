import 'package:flutter/material.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';

Widget TouchEffect({
  required Function onTap,
  required Widget child,
}) {
  return TouchRippleEffect(
    borderRadius: BorderRadius.circular(5),
    rippleColor: Colors.white60,
    backgroundColor: Colors.transparent,
    onTap: () {
      // print("FDSSFD");
      onTap();
    },
    child: child,
  );
}
