import 'package:flutter/material.dart';
import 'package:neo_cafe_24/core/recources/app_fonts.dart';

class ToggleButton extends StatelessWidget {
  final Color textColor;
  final Color buttonColor;
  final String name;
  const ToggleButton({
    super.key,
    required this.buttonColor,
    required this.name,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Center(
          child: Text(
            name,
            style: AppFonts.s12w400
                .copyWith(color: textColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
