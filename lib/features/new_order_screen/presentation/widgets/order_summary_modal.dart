import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cafe_24/core/recources/app_colors.dart';
import 'package:neo_cafe_24/core/recources/app_fonts.dart';
import 'package:neo_cafe_24/features/new_order_screen/presentation/widgets/order_item_container.dart';
import 'package:neo_cafe_24/features/shopping_cart_screen.dart/domain/entity/cart_item_entity.dart';
import 'package:neo_cafe_24/features/shopping_cart_screen.dart/presentation/controller/bloc/cart_bloc.dart';
import 'package:neo_cafe_24/features/widgets/custom_button.dart';

class OrderSummaryModal extends StatelessWidget {
  const OrderSummaryModal({
    super.key,
  });
  double calculateTotal(CartLoadSuccess state) {
    double total = 0;
    for (var item in state.items) {
      total += item.price * item.quantity;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<CartBloc>(context);
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.blue,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(
            24,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoadSuccess) {
              final total = calculateTotal(state);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),
                  Center(
                    child: Text(
                      'Заказ №1',
                      style: AppFonts.s24w600.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.items.length,
                      itemBuilder: (context, index) => OrderItemContainer(
                        quantity: state.items[index].quantity,
                        name: state.items[index].name,
                        price: state.items[index].price,
                        onMinusTap: () {
                          bloc.add(
                            CartItemRemoved(
                              state.items[index].id,
                            ),
                          );
                        },
                        onPlusTap: () {
                          bloc.add(
                            CartItemAdded(
                              CartItemEntity(
                                id: state.items[index].id,
                                image: state.items[index].image,
                                name: state.items[index].name,
                                price: state.items[index].price,
                                quantity: state.items[index].quantity,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Итого: $total c',
                    style: AppFonts.s16w600.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    color: AppColors.orange,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    height: 54,
                    title: Text(
                      'Заказать',
                      style: AppFonts.s16w600.copyWith(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}