import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hinText;
  final TextEditingController controller;
  final bool isObscureText;
  const AuthField(
      {super.key,
      required this.hinText,
      required this.controller,
      this.isObscureText = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(27),
        color: Colors.blueGrey.withOpacity(0.5),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isObscureText,
        decoration: InputDecoration(hintText: hinText),
        validator: (value) {
          if (value!.isEmpty) {
            return "$hinText is missing!";
          }
          return null;
        },
      ),
    );
  }
}
