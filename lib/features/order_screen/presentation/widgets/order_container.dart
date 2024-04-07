import 'package:flutter/material.dart';
import 'package:neo_cafe_24/core/recources/app_colors.dart';
import 'package:neo_cafe_24/core/recources/app_fonts.dart';

class OrderContainer extends StatelessWidget {
  final String status;
  final int tableNumber;
  final String orderNumber;
  final String createdAt;
  final Function()? onTap;
  const OrderContainer({
    super.key,
    required this.status,
    this.onTap,
    required this.createdAt,
    required this.orderNumber,
    required this.tableNumber,
  });

  @override
  Widget build(BuildContext context) {
    Color getColorForStatus(String status) {
      switch (status) {
        case 'Новый':
          return Colors.lightBlue;
        case 'В процессе':
          return AppColors.yellow;
        case 'Завершен':
          return AppColors.green;
        default:
          return Colors.blue;
      }
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.grey,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Стол №$tableNumber',
                  style: AppFonts.s20w600.copyWith(
                    color: AppColors.black,
                  ),
                ),
                const Spacer(),
                Text(
                  '№23144',
                  style: AppFonts.s16w500.copyWith(
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: ShapeDecoration(
                    color: getColorForStatus(status),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  status,
                  style: AppFonts.s16w400.copyWith(
                    color: AppColors.black,
                  ),
                ),
                const Spacer(),
                Text(
                  createdAt,
                  style: AppFonts.s16w600.copyWith(
                    color: AppColors.black,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
