import 'package:flutter/material.dart';
import 'package:gameync/core/themes/app_pallete.dart';

class TourGradientButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  final bool isCreateTour;
  final double height;
  final double width;
  const TourGradientButton(
      {super.key,
      required this.buttonText,
      required this.onTap,
      required this.isCreateTour,
      this.height = 4000,
      this.width = 55});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              AppPallete.gradient1,
              AppPallete.gradient2,
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
          borderRadius: BorderRadius.circular(27)),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            fixedSize: Size(height, width),
            backgroundColor: AppPallete.transparentColor,
            shadowColor: AppPallete.transparentColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
              child: isCreateTour
                  ? Image.asset(
                      'assets/images/icons/20634781001670336766-128.png',
                      color: Colors.white,
                    )
                  : const SizedBox(),
            ),
            isCreateTour
                ? SizedBox(
                    width: 15,
                  )
                : const SizedBox(),
            Text(
              buttonText,
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
