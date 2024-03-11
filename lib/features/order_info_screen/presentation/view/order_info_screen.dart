import 'package:flutter/material.dart';
import 'package:neo_cafe_24/core/recources/app_colors.dart';
import 'package:neo_cafe_24/core/recources/app_fonts.dart';
import 'package:neo_cafe_24/features/new_order_screen/presentation/widgets/info_row.dart';
import 'package:neo_cafe_24/features/new_order_screen/presentation/widgets/order_item_container.dart';
import 'package:neo_cafe_24/features/profile/presentation/widgets/log_out_dialog.dart';
import 'package:neo_cafe_24/features/widgets/app_bar_button.dart';
import 'package:neo_cafe_24/features/widgets/custom_app_bar.dart';
import 'package:neo_cafe_24/features/widgets/custom_button.dart';
import 'package:neo_cafe_24/features/widgets/opacity_button.dart';

class OrderInfoScreen extends StatefulWidget {
  const OrderInfoScreen({super.key});

  @override
  State<OrderInfoScreen> createState() => _OrderInfoScreenState();
}

class _OrderInfoScreenState extends State<OrderInfoScreen> {
  final int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: MyAppBar(
            title: Text(
              'Стол №1',
              style: AppFonts.s24w600.copyWith(color: AppColors.black),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '№3134',
                      style: AppFonts.s14w400.copyWith(
                        color: AppColors.secondGrey,
                      ),
                    ),
                    Text(
                      'Открыт в 18.02',
                      style: AppFonts.s14w400.copyWith(
                        color: AppColors.secondGrey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Официант: Александр',
                  style: AppFonts.s16w600.copyWith(
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 24),
                const InfoRow(
                  color: AppColors.yellow,
                  name: 'В процессе',
                  style: AppFonts.s16w400,
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: OrderItemContainer(
                        onPlusTap: () {},
                        onMinusTap: () {
                          if (quantity == 1) {
                            _showDeleteDialog(context);
                          }
                        },
                        name: 'Латте',
                        price: 100,
                        quantity: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Итог:',
                        style: AppFonts.s16w600.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                      TextSpan(
                        text: '720 c',
                        style: AppFonts.s20w600.copyWith(
                          color: AppColors.orange,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OpacityButton(
                        borderColor: AppColors.blue,
                        title: 'Закрыть счет',
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => const CloseOrderModelWindow(),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 7),
                    Expanded(
                      child: CustomButton(
                        onPressed: () {},
                        height: 54,
                        title: Text(
                          'Добавить',
                          style: AppFonts.s16w600
                              .copyWith(color: AppColors.textWhite),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        _buildArrowBackButton(context)
      ],
    );
  }

  Positioned _buildArrowBackButton(BuildContext context) {
    return Positioned(
      top: 64,
      left: 22,
      child: AppBarButton(
          color: AppColors.blue,
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 16,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          }),
    );
  }
}

Future<dynamic> _showDeleteDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => LogountModalWindow(
      title: 'Удалить чизкейк из\nзаказа?',
      acceptTap: () {},
      declineTap: () {
        Navigator.pop(context);
      },
    ),
  );
}

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
              onPressed: () {},
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
