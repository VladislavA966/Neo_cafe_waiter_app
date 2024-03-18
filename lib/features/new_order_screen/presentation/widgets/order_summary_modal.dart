import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cafe_24/core/recources/app_colors.dart';
import 'package:neo_cafe_24/core/recources/app_fonts.dart';
import 'package:neo_cafe_24/features/error_screen/error_screen.dart';
import 'package:neo_cafe_24/features/new_order_screen/domain/entity/table_entity.dart';
import 'package:neo_cafe_24/features/new_order_screen/presentation/controller/cart_bloc/cart_bloc.dart';
import 'package:neo_cafe_24/features/new_order_screen/presentation/controller/new_order_bloc/new_order_bloc.dart';
import 'package:neo_cafe_24/features/new_order_screen/presentation/widgets/order_item_container.dart';
import 'package:neo_cafe_24/features/new_order_screen/domain/entity/cart_item_entity.dart';
import 'package:neo_cafe_24/features/order_confirmed_screen/presentation/view/order_confirmed_screen.dart';
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
    final orderState = context.read<NewOrderBloc>().state;
    final table = TableEntity(id: 1, tableNumbe: 1, isAvailable: true, branch: 1);
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
                      if (orderState is NewOrderLoading) {
                        return null;
                      }
                      BlocProvider.of<NewOrderBloc>(context).add(
                        SendNewOrderEvent(
                          table: table ,
                        ),
                      );
                    },
                    height: 54,
                    title: BlocConsumer<NewOrderBloc, NewOrderState>(
                      listener: (context, state) {
                        if (state is NewOrderLoaded) {
                          Navigator.pop(context);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const OrderConfirmedScreen(),
                            ),
                          );
                          BlocProvider.of<CartBloc>(context).add(
                            CleanCartEvent(),
                          );
                        } else if (state is NewOrderError) {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ErrorScreen(),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is NewOrderLoading) {
                          return const CircularProgressIndicator();
                        }
                        return Text(
                          'Заказать',
                          style: AppFonts.s16w600.copyWith(color: Colors.white),
                        );
                      },
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
