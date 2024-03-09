import 'package:flutter/material.dart';
import 'package:neo_cafe_24/core/recources/app_colors.dart';
import 'package:neo_cafe_24/core/recources/app_fonts.dart';
import 'package:neo_cafe_24/core/recources/app_images.dart';
import 'package:neo_cafe_24/features/widgets/custom_button.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildImage(),
            const SizedBox(height: 32),
            _buildTitle(),
            const SizedBox(height: 87),
            _buildButton(),
          ],
        ),
      ),
    );
  }

  CustomButton _buildButton() {
    return CustomButton(
              title: Text(
                'Обновить',
                style: AppFonts.s16w600.copyWith(
                  color: Colors.white,
                ),
              ),
              onPressed: () {},
              height: 54);
  }

  Text _buildTitle() {
    return Text(
            'Упс, что-то пошло не так',
            style: AppFonts.s24w500.copyWith(
              color: AppColors.black,
            ),
          );
  }

  Image _buildImage() {
    return Image.asset(
            AppImages.errorImage,
          );
  }
}
