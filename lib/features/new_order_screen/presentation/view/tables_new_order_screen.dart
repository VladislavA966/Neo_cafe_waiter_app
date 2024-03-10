import 'package:flutter/material.dart';
import 'package:neo_cafe_24/core/recources/app_colors.dart';
import 'package:neo_cafe_24/core/recources/app_fonts.dart';
import 'package:neo_cafe_24/core/recources/app_images.dart';
import 'package:neo_cafe_24/features/new_order_screen/presentation/view/new_order_menu_screen.dart';
import 'package:neo_cafe_24/features/new_order_screen/presentation/widgets/info_row.dart';
import 'package:neo_cafe_24/features/notifications_screen/presentation/view/notifications_screen.dart';
import 'package:neo_cafe_24/features/profile/presentation/view/profile_screen.dart';
import 'package:neo_cafe_24/features/widgets/app_bar_button.dart';
import 'package:neo_cafe_24/features/widgets/custom_app_bar.dart';

class NewOrderTableScreen extends StatefulWidget {
  const NewOrderTableScreen({super.key});

  @override
  State<NewOrderTableScreen> createState() => _NewOrderTableScreenState();
}

class _NewOrderTableScreenState extends State<NewOrderTableScreen> {
  void goToCreateNewOrder() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NewOrderMenuScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: _buildAppBar(),
          body: _buildBody(context),
        ),
        _buildAppBarProfileTap(context),
        _buildNotificationButton(context),
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
          _tableNumberTitle(),
          const SizedBox(height: 24),
          _buildInfoTablesRow(),
          const SizedBox(height: 32),
          TableContainer(onTap: goToCreateNewOrder),
        ],
      ),
    );
  }

  Row _buildInfoTablesRow() {
    return const Row(
      children: [
        InfoRow(
          color: AppColors.grey,
          name: 'Занято',
        ),
        SizedBox(width: 32),
        InfoRow(color: AppColors.green, name: 'Свободно')
      ],
    );
  }

  Text _tableNumberTitle() {
    return Text(
      'Выберите стол',
      style: AppFonts.s16w600.copyWith(
        color: AppColors.black,
      ),
    );
  }

  MyAppBar _buildAppBar() {
    return MyAppBar(
      title: Text(
        'Новый заказ',
        style: AppFonts.s24w600.copyWith(
          color: AppColors.black,
        ),
      ),
    );
  }
}

Positioned _buildNotificationButton(BuildContext context) {
  return Positioned(
    top: 65,
    right: 16,
    child: AppBarButton(
        color: AppColors.blue,
        icon: const Icon(
          Icons.notifications_none,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NotificationsScreen(),
            ),
          );
        }),
  );
}

Positioned _buildAppBarProfileTap(BuildContext context) {
  return Positioned(
    top: 65,
    left: 16,
    child: AppBarButton(
        color: AppColors.blue,
        icon: Image.asset(
          AppImages.profileTap,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProfileScreen(),
            ),
          );
        }),
  );
}

class TableContainer extends StatelessWidget {
  final Function()? onTap;

  const TableContainer({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 4,
          right: 4,
          bottom: 8,
        ),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            height: 100,
            padding: const EdgeInsets.symmetric(vertical: 21),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: AppColors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Center(
              child: Text(
                '1',
                style: AppFonts.s48w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
