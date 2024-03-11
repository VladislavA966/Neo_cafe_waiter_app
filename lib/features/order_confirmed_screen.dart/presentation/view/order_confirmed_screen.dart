import 'package:flutter/material.dart';
import 'package:neo_cafe_24/core/recources/app_colors.dart';
import 'package:neo_cafe_24/core/recources/app_fonts.dart';
import 'package:neo_cafe_24/core/recources/app_images.dart';
import 'package:neo_cafe_24/features/home_page/presentation/home_page.dart';
import 'package:neo_cafe_24/features/notifications_screen/presentation/view/notifications_screen.dart';
import 'package:neo_cafe_24/features/profile/presentation/view/profile_screen.dart';
import 'package:neo_cafe_24/features/widgets/app_bar_button.dart';
import 'package:neo_cafe_24/features/widgets/custom_app_bar.dart';
import 'package:neo_cafe_24/features/widgets/custom_button.dart';

class OrderConfirmedScreen extends StatefulWidget {
  const OrderConfirmedScreen({super.key});

  @override
  State<OrderConfirmedScreen> createState() => _OrderConfirmedScreenState();
}

class _OrderConfirmedScreenState extends State<OrderConfirmedScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: _buildAppBar(),
          body: _buildBody(),
        ),
        _buildAppBarProfileTap(context),
        _buildNotificationButton(context),
      ],
    );
  }

  Center _buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildImage(),
            const SizedBox(height: 16),
            _buildTitle(),
            const SizedBox(height: 32),
            _buildButton()
          ],
        ),
      ),
    );
  }

  CustomButton _buildButton() {
    return CustomButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      },
      height: 54,
      title: Text(
        'Перейти к заказам',
        style: AppFonts.s16w600.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }

  Text _buildTitle() {
    return Text(
      'Заказ успешно оформлен',
      style: AppFonts.s24w600.copyWith(
        color: AppColors.black,
      ),
    );
  }

  Image _buildImage() {
    return Image.asset(
      AppImages.checkImage,
    );
  }
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
