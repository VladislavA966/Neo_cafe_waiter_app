import 'package:flutter/material.dart';
import 'package:neo_cafe_24/core/recources/app_colors.dart';
import 'package:neo_cafe_24/core/recources/app_fonts.dart';
import 'package:neo_cafe_24/core/recources/app_images.dart';
import 'package:neo_cafe_24/features/order_info_screen/presentation/widgets/summary_order_column.dart';
import 'package:neo_cafe_24/features/widgets/custom_button.dart';

class CloseOrderModelWindow extends StatelessWidget {
  const CloseOrderModelWindow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 32,
            ),
            const Center(
              child: Text(
                'Закрытие счета',
                style: AppFonts.s24w600,
              ),
            ),
            const SizedBox(height: 24),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SummaryOrderColumn(
                  title: 'Наименование',
                  name: 'Чизкейк',
                  price: '(140 с за шт)',
                ),
                SummaryOrderColumn(title: 'Кол - во', name: '99'),
                SummaryOrderColumn(
                  title: 'Сумма',
                  name: '280 c',
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'До списания бонусов: 730 сом',
              style: AppFonts.s16w600,
            ),
            const SizedBox(height: 54),
            const Spacer(),
            const Text(
              'Итого: 680 c',
              style: AppFonts.s16w600,
            ),
            const SizedBox(height: 16),
            CustomButton(
              onPressed: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    child: SizedBox(
                      height: 176,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(AppImages.checkImage),
                          Text(
                            'Заказ успешно закрыт',
                            style: AppFonts.s20w600
                                .copyWith(color: AppColors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              height: 54,
              title: Text(
                'Сохранить',
                style: AppFonts.s16w600.copyWith(
                  color: AppColors.textWhite,
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
