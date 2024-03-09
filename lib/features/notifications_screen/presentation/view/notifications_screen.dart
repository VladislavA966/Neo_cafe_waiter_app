import 'package:flutter/material.dart';
import 'package:neo_cafe_24/core/recources/app_colors.dart';
import 'package:neo_cafe_24/core/recources/app_fonts.dart';
import 'package:neo_cafe_24/features/notifications_screen/presentation/widgets/notifications_container.dart';
import 'package:neo_cafe_24/features/widgets/app_bar_button.dart';
import 'package:neo_cafe_24/features/widgets/custom_app_bar.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  NotificationContainer buildNotifications(BuildContext context, int index) {
    return const NotificationContainer();
  }

  void navigatorPop() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: _buildAppBar(),
          body: _buildBody(),
        ),
        _buildAppBarbackButton(),
      ],
    );
  }

  Positioned _buildAppBarbackButton() {
    return Positioned(
      top: 65,
      left: 16,
      child: AppBarButton(
          color: AppColors.blue,
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          onPressed: navigatorPop),
    );
  }

  Padding _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(height: 24),
          _clearAllButton(),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: buildNotifications,
            ),
          ),
        ],
      ),
    );
  }

  TextButton _clearAllButton() {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.blue,
        textStyle: AppFonts.s16w600.copyWith(
          color: AppColors.blue,
          decoration: TextDecoration.underline,
        ),
      ),
      onPressed: () {},
      child: const Text(
        'Очистить всё',
      ),
    );
  }

  MyAppBar _buildAppBar() {
    return MyAppBar(
      title: Text(
        'Уведомления',
        style: AppFonts.s24w600.copyWith(
          color: AppColors.black,
        ),
      ),
    );
  }
}


