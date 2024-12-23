import 'package:flutter/material.dart';
import 'package:gameync/core/themes/app_pallete.dart';
import 'package:gameync/core/themes/text_style.dart';

class TimeLine extends StatelessWidget {
  final double cPage;
  const TimeLine({super.key, required this.cPage});

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: 15,
        ),
        Container(
          height: 35,
          width: 85,
          decoration: cPage == 1 ? currentStep() : nextStep(),
          child: Center(
            child: Text(
              'Step 1',
              style: AppStyles.button15(
                  size: 13.5,
                  color: cPage == 1
                      ? Colors.white
                      : Colors.white.withOpacity(0.6)),
            ),
          ),
        ),
        Container(
          height: 3,
          width: 45,
          color: AppPallete.gradient1,
        ),
        Container(
          height: 35,
          width: 85,
          decoration: cPage == 2 ? currentStep() : nextStep(),
          child: Center(
            child: Text(
              'Step 2',
              style: AppStyles.button15(
                  size: 13.5,
                  color: cPage == 2
                      ? Colors.white
                      : Colors.white.withOpacity(0.6)),
            ),
          ),
        ),
        Container(
          height: 3,
          width: 45,
          color: AppPallete.gradient1,
        ),
        Container(
          height: 35,
          width: 85,
          decoration: cPage == 3 ? currentStep() : nextStep(),
          child: Center(
            child: Text(
              'Step 3',
              style: AppStyles.button15(
                  size: 13.5,
                  color: cPage == 3
                      ? Colors.white
                      : Colors.white.withOpacity(0.6)),
            ),
          ),
        ),
      ],
    );
  }

  static BoxDecoration currentStep() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(27),
      gradient: const LinearGradient(
        colors: [
          AppPallete.gradient1,
          AppPallete.gradient2,
        ],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ),
    );
  }

  static BoxDecoration nextStep() {
    return BoxDecoration(
        color: AppPallete.gradient2.withOpacity(0.5),
        border: Border.all(color: AppPallete.gradient1, width: 3),
        borderRadius: BorderRadius.circular(27));
  }
}
