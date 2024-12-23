import 'package:flutter/material.dart';

abstract class AppStyles {
  static TextStyle heading40Bold(
      {Color color = Colors.white, double size = 40.0}) {
    return TextStyle(
      fontSize: size,
      fontWeight: FontWeight.bold,
      color: color,
      fontFamily: 'Poppins',
    );
  }

  static TextStyle button15(
      {Color color = Colors.white,
      double size = 16,
      FontWeight fweight = FontWeight.w600}) {
    return TextStyle(
        color: color,
        fontSize: size,
        fontWeight: fweight,
        fontFamily: 'Poppins');
  }

  static TextStyle appBar30({
    Color color = Colors.white,
    double size = 30,
  }) {
    return TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w600,
        fontFamily: 'Poppins');
  }

  static TextStyle time30({
    Color color = Colors.white,
  }) {
    return TextStyle(
        color: color,
        fontSize: 28,
        letterSpacing: 3,
        fontWeight: FontWeight.w600,
        fontFamily: 'Poppins');
  }

  static TextStyle info14({Color color = Colors.white, double size = 14}) {
    return TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w600,
        fontFamily: 'Poppins');
  }

  static TextStyle gameName({Color color = Colors.white, double size = 14}) {
    return TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w400,
        fontFamily: 'Poppins');
  }

  static TextStyle listItem(
      {FontWeight fweight = FontWeight.w500,
      Color color = Colors.white,
      double size = 14}) {
    return TextStyle(
        color: color.withOpacity(0.8),
        fontSize: size,
        fontWeight: fweight,
        fontFamily: 'Poppins');
  }

  static TextStyle listTitle({Color color = Colors.white, double size = 14}) {
    return TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.normal,
        fontFamily: 'Poppins');
  }
}
