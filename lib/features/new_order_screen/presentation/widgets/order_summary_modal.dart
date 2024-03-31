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
  final TableEntity table;
  const OrderSummaryModal({
    super.key,
    required this.table,
  });
  double calculateTotal(CartLoadSuccess state) {
    double total = 0;
    for (var item in state.items) {
      total += item.price * item.quantity;
    }
    return total;
  }

  void _addItem(CartBloc bloc, CartLoadSuccess state, int index) {
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
  }

  void _newOrderError(BuildContext context) {
    Navigator.pop(context);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const ErrorScreen(),
      ),
      (Route<dynamic> route) => false,
    );
  }

  void _newOrderLoaded(BuildContext context) {
    Navigator.pop(context);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const OrderConfirmedScreen(),
      ),
      (Route<dynamic> route) => false,
    );
    BlocProvider.of<CartBloc>(context).add(
      CleanCartEvent(),
    );
  }

  void _removeItem(
      CartLoadSuccess state, int index, CartBloc bloc, BuildContext context) {
    if (state.items[index].quantity == 1) {
      bloc.add(
        CartItemRemoved(
          state.items[index].id,
        ),
      );
      Navigator.pop(context);
    }
    bloc.add(
      CartItemRemoved(
        state.items[index].id,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final orderState = context.read<NewOrderBloc>().state;
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
              return _cartLoadSuccess(state, bloc, total, orderState, context);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Column _cartLoadSuccess(CartLoadSuccess state, CartBloc bloc, double total,
      NewOrderState orderState, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        _buildTableTitle(),
        const SizedBox(height: 24),
        _buildItemListViewBuilder(state, bloc),
        const SizedBox(height: 8),
        _buildTotalPrice(total),
        const SizedBox(height: 16),
        _buildCustomButton(orderState, context),
        const SizedBox(height: 16),
      ],
    );
  }

  Center _buildTableTitle() {
    return Center(
      child: Text(
        'Заказ №1',
        style: AppFonts.s24w600.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }

  CustomButton _buildCustomButton(
      NewOrderState orderState, BuildContext context) {
    return CustomButton(
      color: AppColors.orange,
      onPressed: () {
        if (orderState is NewOrderLoading) {
          return null;
        }
        BlocProvider.of<NewOrderBloc>(context).add(
          SendNewOrderEvent(
            table: table,
          ),
        );
      },
      height: 54,
      title: BlocConsumer<NewOrderBloc, NewOrderState>(
        listener: (context, state) {
          if (state is NewOrderLoaded) {
            _newOrderLoaded(context);
          } else if (state is NewOrderError) {
            _newOrderError(context);
          }
        },
        builder: (context, state) {
          if (state is NewOrderLoading) {
            return _newOrderLoadingBuilder();
          }
          return Text(
            'Заказать',
            style: AppFonts.s16w600.copyWith(color: Colors.white),
          );
        },
      ),
    );
  }

  CircularProgressIndicator _newOrderLoadingBuilder() {
    return const CircularProgressIndicator();
  }

  Expanded _buildItemListViewBuilder(CartLoadSuccess state, CartBloc bloc) {
    return Expanded(
      child: ListView.builder(
        itemCount: state.items.length,
        itemBuilder: (context, index) =>
            _buildItemOrderContainer(state, index, bloc, context),
      ),
    );
  }

  Text _buildTotalPrice(double total) {
    return Text(
      'Итого: $total c',
      style: AppFonts.s16w600.copyWith(
        color: Colors.white,
      ),
    );
  }

  OrderItemContainer _buildItemOrderContainer(
      CartLoadSuccess state, int index, CartBloc bloc, BuildContext context) {
    return OrderItemContainer(
      quantity: state.items[index].quantity,
      name: state.items[index].name,
      price: state.items[index].price,
      onMinusTap: () => _removeItem(state, index, bloc, context),
      onPlusTap: () => _addItem(bloc, state, index),
    );
  }
}
