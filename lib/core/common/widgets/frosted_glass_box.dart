import 'dart:ui';

import 'package:flutter/material.dart';

class FrostedGlassBox extends StatelessWidget {
  const FrostedGlassBox({
    Key? key,
    required this.theWidth,
    required this.theHeight,
    required this.theChild,
    this.theRadius = 20,
    this.theRadius2 = 30,
    this.bgcolor = Colors.transparent,
  }) : super(key: key);

  final double theWidth;
  final double theHeight;
  final Widget theChild;
  final double theRadius;
  final double theRadius2;
  final Color bgcolor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(theRadius),
      child: Container(
        decoration: BoxDecoration(color: bgcolor),
        width: theWidth,
        height: theHeight,
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2.9, sigmaY: 2.9),
              child: Container(),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(theRadius2),
                  border: Border.all(color: Colors.white.withOpacity(0.03)),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.grey.withOpacity(0.15),
                        Colors.grey.withOpacity(0.15),
                      ])),
            ),
            Center(
              child: theChild,
            )
          ],
        ),
      ),
    );
  }
}
