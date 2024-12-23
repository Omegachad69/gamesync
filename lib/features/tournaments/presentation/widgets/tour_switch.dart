import 'package:flutter/material.dart';
import 'package:gameync/core/common/widgets/frosted_glass_box.dart';
import 'package:gameync/core/themes/app_pallete.dart';
import 'package:gameync/core/themes/text_style.dart';

class TourSwitch extends StatelessWidget {
  const TourSwitch({
    super.key,
    required this.text1,
    required this.text2,
    required this.onTap1,
    required this.onTap2,
    required this.tapped,
  });
  final String text1;
  final String text2;
  final VoidCallback onTap1;
  final VoidCallback onTap2;
  final int tapped;
  @override
  Widget build(BuildContext context) {
    var boxDecoration = BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppPallete.gradient1,
            AppPallete.gradient2,
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(27));

    return FrostedGlassBox(
        theWidth: double.infinity,
        theHeight: 60,
        theChild: Padding(
          padding: const EdgeInsets.all(8.0).copyWith(left: 14, right: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: onTap1,
                child: Container(
                  width: 160,
                  height: 36,
                  decoration: tapped == 1 ? boxDecoration : BoxDecoration(),
                  child: Center(
                    child: Text(
                      text1,
                      style: AppStyles.button15(),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: onTap2,
                child: Container(
                  width: 160,
                  height: 36,
                  decoration: tapped == 2 ? boxDecoration : BoxDecoration(),
                  child: Center(
                    child: Text(
                      text2,
                      style: AppStyles.button15(),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
