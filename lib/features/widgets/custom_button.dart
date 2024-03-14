import 'package:flutter/material.dart';
import 'package:neo_cafe_24/core/recources/app_colors.dart';

class CustomButton extends StatelessWidget {
  final double height;
  final Widget? orderTitle;
  final double? width;
  final Function()? onPressed;
  final Color? color;
  final Widget? title;
  const CustomButton({
    super.key,
    this.title,
    this.color = AppColors.blue,
    this.orderTitle,
    required this.onPressed,
    required this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  16,
                ),
              ),
              backgroundColor: color),
          onPressed: onPressed,
          child: title ?? orderTitle),
    );
  }
}
