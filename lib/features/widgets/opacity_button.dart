import 'package:flutter/material.dart';
import 'package:neo_cafe_24/core/recources/app_fonts.dart';

class OpacityButton extends StatelessWidget {
  final Color borderColor;
  final String title;
  final Function() onPressed;
  const OpacityButton(
      {super.key,
      required this.borderColor,
      required this.title,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: borderColor,
            ),
            borderRadius: BorderRadius.circular(
              16,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: AppFonts.s16w600.copyWith(
            color: borderColor,
          ),
        ),
      ),
    );
  }
}
