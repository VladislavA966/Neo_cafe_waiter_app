import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cafe_24/core/recources/app_colors.dart';
import 'package:neo_cafe_24/core/recources/app_fonts.dart';
import 'package:neo_cafe_24/core/recources/app_images.dart';
import 'package:neo_cafe_24/features/order_info_screen/presentation/view/bloc/order_info_bloc.dart';
import 'package:neo_cafe_24/features/widgets/custom_button.dart';

class CloseOrderModelWindow extends StatelessWidget {
  const CloseOrderModelWindow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderInfoBloc, OrderInfoState>(
      builder: (context, state) {
        if (state is OrderInfoLoaded) {
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
                      Text(
                        'Наименование',
                        style: AppFonts.s14w600,
                      ),
                      Text(
                        'Кол-во',
                        style: AppFonts.s14w600,
                      ),
                      Text(
                        'Сумма',
                        style: AppFonts.s14w600,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.order.items.length,
                      itemBuilder: (context, index) {
                        final item = state.order.items[index];
                        final totalPrice = item.quantity * item.totalPrice;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  "${item.itemName}\n(${item.totalPrice} с за штуку)",
                                ),
                              ),
                              SizedBox(
                                width: 150,
                                child: Text(
                                  "${item.quantity}",
                                ),
                              ),
                              SizedBox(
                                width: 40,
                                child: Text(
                                  "$totalPrice с",
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 54),
                  const Spacer(),
                  Text(
                    'Итого: ${state.order.totalSum} c',
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
        return const SizedBox();
      },
    );
  }
}
