import 'dart:ui';

import 'package:flutter/material.dart';

class TtextPage extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final double height;
  final int maxLine;
  final bool isNumber;

  const TtextPage(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.height,
      required this.maxLine,
      required this.isNumber});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(27),
      child: Container(
        width: 600,
        height: height,
        decoration: const BoxDecoration(color: Colors.transparent),
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2.9, sigmaY: 2.9),
              child: Container(),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(27),
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
              child: TextFormField(
                keyboardType:
                    isNumber ? TextInputType.number : TextInputType.text,
                maxLines: 10,
                controller: controller,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: hintText, errorStyle: TextStyle(height: 0)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
