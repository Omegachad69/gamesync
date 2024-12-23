import 'package:flutter/material.dart';
import 'package:gameync/core/themes/app_pallete.dart';

class AuthGradientButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  const AuthGradientButton(
      {super.key, required this.buttonText, required this.onTap});

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
            fixedSize: const Size(4000, 55),
            backgroundColor: AppPallete.transparentColor,
            shadowColor: AppPallete.transparentColor),
        child: Text(
          buttonText,
          style: const TextStyle(
              fontWeight: FontWeight.w600, fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
