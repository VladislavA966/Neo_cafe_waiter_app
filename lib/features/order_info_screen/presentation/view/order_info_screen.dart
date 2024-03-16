import 'package:flutter/material.dart';
import 'package:neo_cafe_24/core/recources/app_colors.dart';
import 'package:neo_cafe_24/core/recources/app_fonts.dart';
import 'package:neo_cafe_24/core/recources/app_images.dart';
import 'package:neo_cafe_24/features/new_order_screen/presentation/widgets/info_row.dart';
import 'package:neo_cafe_24/features/new_order_screen/presentation/widgets/order_item_container.dart';
import 'package:neo_cafe_24/features/order_info_screen/presentation/widgets/close_order_modal.dart';
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
          appBar: _buildAppBar(),
          body: _buildBody(context),
        ),
        _buildArrowBackButton(context)
      ],
    );
  }

  Padding _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildOrderNumber(),
              _buildOrderTime(),
            ],
          ),
          const SizedBox(height: 16),
          _buildOrderWaiter(),
          const SizedBox(height: 24),
          _buildOrderStatus(),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) => _buildOrderContainer(context),
            ),
          ),
          const SizedBox(height: 12),
          _buildTotalPrice(),
          const SizedBox(height: 24),
          Row(
            children: [
              _cloceOrderButton(context),
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

  Expanded _cloceOrderButton(BuildContext context) {
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

  Text _buildTotalPrice() {
    return Text.rich(
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
    );
  }

  Padding _buildOrderContainer(BuildContext context) {
    return Padding(
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
    );
  }

  InfoRow _buildOrderStatus() {
    return const InfoRow(
      color: AppColors.yellow,
      name: 'В процессе',
      style: AppFonts.s16w400,
    );
  }

  Text _buildOrderWaiter() {
    return Text(
      'Официант: Александр',
      style: AppFonts.s16w600.copyWith(
        color: AppColors.black,
      ),
    );
  }

  Text _buildOrderTime() {
    return Text(
      'Открыт в 18.02',
      style: AppFonts.s14w400.copyWith(
        color: AppColors.secondGrey,
      ),
    );
  }

  Text _buildOrderNumber() {
    return Text(
      '№3134',
      style: AppFonts.s14w400.copyWith(
        color: AppColors.secondGrey,
      ),
    );
  }

  MyAppBar _buildAppBar() {
    return MyAppBar(
      title: Text(
        'Стол №1',
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
