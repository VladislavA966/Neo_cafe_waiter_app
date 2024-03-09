import 'package:flutter/material.dart';
import 'package:neo_cafe_24/core/recources/app_colors.dart';
import 'package:neo_cafe_24/core/recources/app_fonts.dart';

class NotificationContainer extends StatelessWidget {
  const NotificationContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.black,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Заказ готов',
                    style: AppFonts.s16w600.copyWith(
                      color: AppColors.orange,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '19:02',
                    style: AppFonts.s16w600.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
              Text(
                'Капучино x1, Американо x2, Багровай за...',
                style: AppFonts.s14w400.copyWith(color: AppColors.black),
              )
            ],
          ),
        ),
      ),
    );
  }
}
