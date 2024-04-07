import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cafe_24/core/recources/app_colors.dart';
import 'package:neo_cafe_24/core/recources/app_fonts.dart';
import 'package:neo_cafe_24/features/new_order_screen/presentation/widgets/info_row.dart';
import 'package:neo_cafe_24/features/new_order_screen/presentation/widgets/order_item_container.dart';
import 'package:neo_cafe_24/features/order_info_screen/presentation/view/bloc/order_info_bloc.dart';
import 'package:neo_cafe_24/features/order_info_screen/presentation/widgets/close_order_modal.dart';
import 'package:neo_cafe_24/features/profile/presentation/widgets/log_out_dialog.dart';
import 'package:neo_cafe_24/features/widgets/app_bar_button.dart';
import 'package:neo_cafe_24/features/widgets/custom_app_bar.dart';
import 'package:neo_cafe_24/features/widgets/custom_button.dart';
import 'package:neo_cafe_24/features/widgets/opacity_button.dart';

class OrderInfoScreen extends StatefulWidget {
  final int tableNumber;
  const OrderInfoScreen({super.key, required this.tableNumber});

  @override
  State<OrderInfoScreen> createState() => _OrderInfoScreenState();
}

class _OrderInfoScreenState extends State<OrderInfoScreen> {
  final int quantity = 1;
  @override
  void initState() {
    BlocProvider.of<OrderInfoBloc>(context).add(
      GerOrderInfoEvent(tableNumber: widget.tableNumber),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderInfoBloc, OrderInfoState>(
      builder: (context, state) {
        if (state is OrderInfoLoaded) {
          return _buildOrderInfoLoadedState(state, context);
        } else if (state is OrderInfoLoading) {
          return _buildOrderInfoLoadingState();
        }
        return const SizedBox();
      },
    );
  }

  Stack _buildOrderInfoLoadedState(
      OrderInfoLoaded state, BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: _buildAppBar(state),
          body: _buildBody(context, state),
        ),
        _buildArrowBackButton(context)
      ],
    );
  }

  Scaffold _buildOrderInfoLoadingState() {
    return const Scaffold(
      appBar: MyAppBar(
        title: Text(''),
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Padding _buildBody(BuildContext context, OrderInfoLoaded state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildOrderNumber(state),
              _buildOrderTime(state),
            ],
          ),
          const SizedBox(height: 16),
          _buildOrderWaiter(state),
          const SizedBox(height: 24),
          _buildOrderStatus(state),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: state.order.items.length,
              itemBuilder: (context, index) =>
                  _buildOrderContainer(context, state, index),
            ),
          ),
          const SizedBox(height: 12),
          _buildTotalPrice(state),
          const SizedBox(height: 24),
          Row(
            children: [
              _closeOrderButton(context),
              const SizedBox(width: 7),
              _buildAddItemsButton()
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Expanded _buildAddItemsButton() {
    return Expanded(
      child: CustomButton(
        onPressed: () {},
        height: 54,
        title: Text(
          'Добавить',
          style: AppFonts.s16w600.copyWith(color: AppColors.textWhite),
        ),
      ),
    );
  }

  Expanded _closeOrderButton(BuildContext context) {
    return Expanded(
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
    );
  }

  Text _buildTotalPrice(OrderInfoLoaded state) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'Итог: ',
            style: AppFonts.s16w600.copyWith(
              color: AppColors.black,
            ),
          ),
          TextSpan(
            text: '${state.order.totalSum} c',
            style: AppFonts.s20w600.copyWith(
              color: AppColors.orange,
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildOrderContainer(
      BuildContext context, OrderInfoLoaded state, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: OrderItemContainer(
        onPlusTap: () {},
        onMinusTap: () {
          if (quantity == 1) {
            _showDeleteDialog(context);
          }
        },
        name: state.order.items[index].itemName,
        price: state.order.items[index].totalPrice,
        quantity: state.order.items[index].quantity,
      ),
    );
  }

  InfoRow _buildOrderStatus(OrderInfoLoaded state) {
    return InfoRow(
      color: AppColors.yellow,
      name: state.order.orderStatus,
      style: AppFonts.s16w400,
    );
  }

  Text _buildOrderWaiter(OrderInfoLoaded state) {
    return Text(
      'Официант: ${state.order.employee?.username}',
      style: AppFonts.s16w600.copyWith(
        color: AppColors.black,
      ),
    );
  }

  Text _buildOrderTime(OrderInfoLoaded state) {
    return Text(
      'Открыт в ${state.order.createdAt}',
      style: AppFonts.s14w400.copyWith(
        color: AppColors.secondGrey,
      ),
    );
  }

  Text _buildOrderNumber(OrderInfoLoaded state) {
    return Text(
      '№${state.order.orderNumber}',
      style: AppFonts.s14w400.copyWith(
        color: AppColors.secondGrey,
      ),
    );
  }

  MyAppBar _buildAppBar(OrderInfoLoaded state) {
    return MyAppBar(
      title: Text(
        'Стол ${state.order.table?.tableNumbe}',
        style: AppFonts.s24w600.copyWith(color: AppColors.black),
      ),
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
        onPressed: () => _navigateBackPage(context),
      ),
    );
  }

  void _navigateBackPage(BuildContext context) {
    Navigator.pop(context);
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
