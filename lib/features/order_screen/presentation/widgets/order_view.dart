import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cafe_24/core/recources/app_colors.dart';
import 'package:neo_cafe_24/features/error_screen/error_screen.dart';
import 'package:neo_cafe_24/features/order_info_screen/presentation/view/order_info_screen.dart';
import 'package:neo_cafe_24/features/order_screen/presentation/controller/bloc/all_orders_bloc.dart';
import 'package:neo_cafe_24/features/order_screen/presentation/widgets/order_container.dart';
import 'package:neo_cafe_24/features/order_screen/presentation/widgets/toggle_button.dart';

class OrdersBody extends StatefulWidget {
  const OrdersBody({super.key});

  @override
  State<OrdersBody> createState() => _OrdersBodyState();
}

class _OrdersBodyState extends State<OrdersBody> {
  List<String> buttonNames = ['Все', 'Новые', 'В процессе', 'Готово'];
  int? selectedIndex = 0;
  void _toggleButtonTap(int index) {
    setState(() {
      selectedIndex = index;
    });
    final status = _getStatusFromIndex(index);
    context.read<AllOrdersBloc>().add(FilterOrdersByStatus(status));
  }

  String _getStatusFromIndex(int index) {
    switch (index) {
      case 1:
        return "Новые";
      case 2:
        return "В процессе";
      case 3:
        return "Готово";
      default:
        return "Все";
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AllOrdersBloc, AllOrdersState>(
      listener: (context, state) {
        if (state is AllOrdersError) {
          _goToErrorScreen(context);
        }
      },
      builder: (context, state) {
        if (state is AllOrdersLoading) {
          return _buildLoadingState();
        } else if (state is AllOrdersLoaded) {
          return _buildLoadedState(state);
        }
        return const SizedBox();
      },
    );
  }

  Padding _buildLoadedState(AllOrdersLoaded state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 48),
          _toggleButtonListViewBuilder(),
          const SizedBox(height: 20),
          _itemsListViewBuilder(state)
        ],
      ),
    );
  }

  Widget _itemsListViewBuilder(AllOrdersLoaded state) {
    if (state.orders.isEmpty) {
      return const Center(
        child: Text("В этой категории нет заказов"),
      );
    }
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: state.orders.length,
        itemBuilder: (context, index) {
          return _buildOrderContainer(state, index);
        },
      ),
    );
  }

  SizedBox _toggleButtonListViewBuilder() {
    return SizedBox(
      height: 38,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: buttonNames.length,
        itemBuilder: _buildToggleButtons,
      ),
    );
  }

  Padding _buildOrderContainer(AllOrdersLoaded state, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: OrderContainer(
        onTap: () => _goToOrderInfo(state, index),
        status: state.orders[index].orderStatus,
        createdAt: state.orders[index].createdAt,
        orderNumber: state.orders[index].orderType,
        tableNumber: state.orders[index].table?.tableNumbe ?? 0,
      ),
    );
  }

  void _goToOrderInfo(AllOrdersLoaded state, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderInfoScreen(
          tableNumber: state.orders[index].table?.tableNumbe ?? 0,
        ),
      ),
    );
  }

  Widget? _buildToggleButtons(context, index) {
    Color textColor = selectedIndex == index ? Colors.white : Colors.black;
    Color buttonColor =
        selectedIndex == index ? AppColors.orange : AppColors.grey;
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: GestureDetector(
        onTap: () => _toggleButtonTap(index),
        child: ToggleButton(
          textColor: textColor,
          buttonColor: buttonColor,
          name: buttonNames[index],
        ),
      ),
    );
  }

  Center _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  void _goToErrorScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ErrorScreen(),
      ),
    );
  }
}
