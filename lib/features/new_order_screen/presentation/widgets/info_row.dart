import 'package:flutter/material.dart';
import 'package:neo_cafe_24/core/recources/app_fonts.dart';

class InfoRow extends StatelessWidget {
  final Color color;
  final String name;
  final TextStyle? style;
  const InfoRow({
    super.key,
    required this.color,
    required this.name,
    this.style = AppFonts.s14w400,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: ShapeDecoration(
            color: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          name,
          style: style,
        )
      ],
    );
  }
}
