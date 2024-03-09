import 'package:flutter/material.dart';
import 'package:neo_cafe_24/core/recources/app_colors.dart';
import 'package:neo_cafe_24/core/recources/app_fonts.dart';

class MenuContainer extends StatelessWidget {
  final String name;
  final int price;
  const MenuContainer({
    super.key,
    required this.name,
    required this.price,
  });
  List<BoxShadow> get shadows => const [
        BoxShadow(
          color: Color(0x0F000000),
          blurRadius: 8,
          offset: Offset(0, 4),
          spreadRadius: 0,
        ),
        BoxShadow(
          color: Color(0x0A000000),
          blurRadius: 4,
          offset: Offset(0, 0),
          spreadRadius: 0,
        ),
      ];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      padding: const EdgeInsets.only(
        top: 19,
        left: 16,
        right: 16,
        bottom: 18,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadows: shadows,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: AppFonts.s16w600.copyWith(
              color: AppColors.black,
            ),
          ),
          Text(
            '$price c',
            style: AppFonts.s16w600.copyWith(color: AppColors.blue),
          )
        ],
      ),
    );
  }
}
