import 'package:flutter/material.dart';
import 'package:neo_cafe_24/core/recources/app_colors.dart';
import 'package:neo_cafe_24/core/recources/app_fonts.dart';

class TableContainer extends StatelessWidget {
  final Function()? onTap;
  final int tableNumber;
  final bool isAvailable;

  const TableContainer(
      {super.key,
      required this.onTap,
      required this.tableNumber,
      required this.isAvailable});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 4,
        right: 4,
        bottom: 8,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 100,
          padding: const EdgeInsets.symmetric(vertical: 21),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: isAvailable ? AppColors.green : AppColors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Center(
            child: Text(
              "$tableNumber",
              style: AppFonts.s48w400,
            ),
          ),
        ),
      ),
    );
  }
}
