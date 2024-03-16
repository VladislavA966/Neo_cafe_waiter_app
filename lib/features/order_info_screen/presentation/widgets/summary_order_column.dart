import 'package:flutter/widgets.dart';
import 'package:neo_cafe_24/core/recources/app_colors.dart';
import 'package:neo_cafe_24/core/recources/app_fonts.dart';

class SummaryOrderColumn extends StatelessWidget {
  final String title;
  final String name;
  final String? price;

  const SummaryOrderColumn({
    super.key,
    required this.title,
    required this.name,
    this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppFonts.s14w600.copyWith(
            color: AppColors.black,
          ),
        ),
        const SizedBox(height: 16),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '$name\n',
                style: AppFonts.s16w400,
              ),
              TextSpan(
                text: price ?? '',
                style: AppFonts.s14w400.copyWith(
                  color: AppColors.secondGrey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}