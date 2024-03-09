import 'package:flutter/material.dart';
import 'package:neo_cafe_24/core/recources/app_colors.dart';
import 'package:neo_cafe_24/core/recources/app_fonts.dart';

class ButtonsRow extends StatelessWidget {
  final int counter;
  final Function() onMinusTap;
  final Function() onPlusTap;
  const ButtonsRow(
      {super.key,
      required this.counter,
      required this.onMinusTap,
      required this.onPlusTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleButton(
          width: 36,
          height: 36,
          onTap: onMinusTap,
          color: AppColors.grey,
          icon: Icons.remove,
          iconSize: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            '$counter',
            style: AppFonts.s16w600.copyWith(
              color: AppColors.black,
            ),
          ),
        ),
        CircleButton(
          iconColor: Colors.white,
          iconSize: 15,
          width: 36,
          height: 36,
          color: AppColors.orange,
          icon: Icons.add,
          onTap: onPlusTap,
        ),
        const SizedBox(
          width: 20,
        ),
      ],
    );
  }
}

class CircleButton extends StatelessWidget {
  final Color? iconColor;
  final Color color;
  final IconData icon;
  final Function()? onTap;
  final double height;
  final double width;
  final double iconSize;
  const CircleButton(
      {super.key,
      required this.color,
      required this.icon,
      required this.onTap,
      required this.height,
      required this.width,
      required this.iconSize,
      this.iconColor = AppColors.black});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(8),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: iconSize,
        ),
      ),
    );
  }
}
