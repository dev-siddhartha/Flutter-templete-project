import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_template/core/widgets/pagination/draw_dot.dart';

class SwivelDot extends StatelessWidget {
  final double dotSize;
  final Offset rotationOrigin;
  final Color color;
  final AnimationController controller;
  final bool left;
  final double firstInterval;
  final double secondInterval;
  final double thirdInterval;
  final double fourthInterval;

  const SwivelDot.left({
    super.key,
    required this.color,
    required this.dotSize,
    required this.rotationOrigin,
    required this.controller,
    required this.firstInterval,
    required this.secondInterval,
    required this.thirdInterval,
    required this.fourthInterval,
  }) : left = true;

  const SwivelDot.right({
    super.key,
    required this.color,
    required this.dotSize,
    required this.rotationOrigin,
    required this.controller,
    required this.firstInterval,
    required this.secondInterval,
    required this.thirdInterval,
    required this.fourthInterval,
  }) : left = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Visibility(
          visible: controller.value <= thirdInterval,
          child: Transform.rotate(
            origin: rotationOrigin,
            angle: Tween<double>(
              begin: 0.0,
              end: left ? math.pi / 5 : -math.pi / 5,
            )
                .animate(
                  CurvedAnimation(
                    parent: controller,
                    curve: Interval(
                      firstInterval,
                      secondInterval,
                    ),
                  ),
                )
                .value,
            child: DrawDot.circular(
              color: color,
              dotSize: dotSize,
            ),
          ),
        ),
        Visibility(
          visible: controller.value >= thirdInterval,
          child: Transform.rotate(
            origin: rotationOrigin,
            angle: Tween<double>(
              begin: left ? math.pi / 5 : -math.pi / 5,
              end: 0.0,
            )
                .animate(
                  CurvedAnimation(
                    parent: controller,
                    curve: Interval(
                      thirdInterval,
                      fourthInterval,
                    ),
                  ),
                )
                .value,
            child: DrawDot.circular(
              color: color,
              dotSize: dotSize,
            ),
          ),
        ),
      ],
    );
  }
}
