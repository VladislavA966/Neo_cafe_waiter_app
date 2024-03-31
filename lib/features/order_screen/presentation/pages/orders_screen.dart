import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cafe_24/core/recources/app_colors.dart';
import 'package:neo_cafe_24/core/recources/app_fonts.dart';
import 'package:neo_cafe_24/core/recources/app_images.dart';
import 'package:neo_cafe_24/features/notifications_screen/presentation/view/notifications_screen.dart';
import 'package:neo_cafe_24/features/order_screen/presentation/controller/bloc/all_orders_bloc.dart';
import 'package:neo_cafe_24/features/order_screen/presentation/widgets/order_view.dart';
import 'package:neo_cafe_24/features/order_screen/presentation/widgets/tables_view.dart';
import 'package:neo_cafe_24/features/profile/presentation/view/profile_screen.dart';
import 'package:neo_cafe_24/features/widgets/app_bar_button.dart';
import 'package:neo_cafe_24/features/widgets/custom_app_bar.dart';
import 'package:toggle_switch/toggle_switch.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  int? currentIndex = 0;
  List<List<Color>> get acticeColors => const [
        [AppColors.orange],
        [AppColors.orange],
      ];
  void _currentIndexTap(index) {
    currentIndex = index;
    setState(() {});
  }

  @override
  void initState() {
    BlocProvider.of<AllOrdersBloc>(context).add(
      GetAllOrders(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: _buildAppBar(),
          body: currentIndex == 0 ? const TablesBody() : const OrdersBody(),
        ),
        _buildAppBarProfileTap(context),
        _buildNotificationButton(context),
        _buildToggleButtons(),
      ],
    );
  }

  Positioned _buildToggleButtons() {
    return Positioned(
      top: 156,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ToggleSwitch(
          minWidth: double.infinity,
          minHeight: 48,
          cornerRadius: 100,
          activeBgColors: acticeColors,
          activeFgColor: Colors.white,
          inactiveBgColor: AppColors.grey,
          inactiveFgColor: Colors.black,
          initialLabelIndex: currentIndex,
          totalSwitches: 2,
          labels: const ['Столы', 'Заказы'],
          radiusStyle: true,
          onToggle: _currentIndexTap,
        ),
      ),
    );
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
        onPressed: () => _goToNotificationsScreen(context),
      ),
    );
  }

  void _goToNotificationsScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NotificationsScreen(),
      ),
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
        onPressed: () => _goToNotificationScreen(context),
      ),
    );
  }

  void _goToNotificationScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfileScreen(),
      ),
    );
  }

  MyAppBar _buildAppBar() {
    return MyAppBar(
      title: Text(
        'Заказы',
        style: AppFonts.s24w600.copyWith(
          color: AppColors.black,
        ),
      ),
    );
  }
}
