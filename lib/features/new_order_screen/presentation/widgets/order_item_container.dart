import 'package:flutter/material.dart';
import 'package:neo_cafe_24/core/recources/app_colors.dart';
import 'package:neo_cafe_24/core/recources/app_fonts.dart';
import 'package:neo_cafe_24/features/new_order_screen/presentation/widgets/buttons_row.dart';

class OrderItemContainer extends StatelessWidget {
  final String name;
  final int price;
  final int quantity;
  final Function()? onPlusTap;
  final Function()? onMinusTap;
  const OrderItemContainer({
    super.key,
    required this.onPlusTap,
    required this.onMinusTap,
    required this.name,
    required this.price,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 12,
            left: 16,
            bottom: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$name ($price с за шт)',
                      style: AppFonts.s14w600.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Коровье молоко',
                      style: AppFonts.s14w400.copyWith(color: AppColors.black),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Карамельный сироп',
                      style: AppFonts.s14w400.copyWith(
                        color: AppColors.black,
                      ),
                    )
                  ],
                ),
              ),
              ButtonsRow(
                counter: quantity,
                onMinusTap: onMinusTap ?? () {},
                onPlusTap: onPlusTap ?? () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
