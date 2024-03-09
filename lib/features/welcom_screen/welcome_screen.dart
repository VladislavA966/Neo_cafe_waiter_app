import 'package:flutter/material.dart';
import 'package:neo_cafe_24/core/recources/app_colors.dart';
import 'package:neo_cafe_24/core/recources/app_fonts.dart';
import 'package:neo_cafe_24/core/recources/app_images.dart';
import 'package:neo_cafe_24/features/widgets/custom_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.mainColors, body: _buildBody(context));
  }

  Stack _buildBody(BuildContext context) {
    return Stack(
      children: [
        _buildDecorationImage(),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildMainImage(),
                const SizedBox(
                  height: 48,
                ),
                _buildTitle(),
                const SizedBox(
                  height: 24,
                ),
                _buildTitleImage(),
                const SizedBox(
                  height: 75,
                ),
                _buildButton(context),
                const SizedBox(
                  height: 64,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Positioned _buildDecorationImage() {
    return Positioned(
      top: 0,
      right: 0,
      child: Image.asset(AppImages.coffeeBeans),
    );
  }

  CustomButton _buildButton(BuildContext context) {
    return CustomButton(
      height: 54,
      title: Text(
          'Вперед!',
          style: AppFonts.s16w600.copyWith(
            color: Colors.white,
          ),
        ),
      onPressed: () {},
    );
  }

  Image _buildTitleImage() {
    return Image.asset(
      AppImages.neocafe,
    );
  }

  Text _buildTitle() {
    return Text(
      'Добро пожаловать в',
      style: AppFonts.s20w600.copyWith(
        color: Colors.white,
      ),
    );
  }

  Image _buildMainImage() => Image.asset(AppImages.welcomeScreen);
}
