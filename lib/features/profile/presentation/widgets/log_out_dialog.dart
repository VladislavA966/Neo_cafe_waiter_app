import 'package:flutter/material.dart';
import 'package:neo_cafe_24/core/recources/app_colors.dart';
import 'package:neo_cafe_24/core/recources/app_fonts.dart';
import 'package:neo_cafe_24/features/auth/presentation/view/auth_screen.dart';
import 'package:neo_cafe_24/features/widgets/custom_button.dart';
import 'package:neo_cafe_24/features/widgets/opacity_button.dart';

class LogountModalWindow extends StatelessWidget {
  final String title;
  final Function() acceptTap;
  final Function() declineTap;
  const LogountModalWindow({
    super.key,
    required this.title,
    required this.acceptTap,
    required this.declineTap,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      child: Container(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _exitTitle(),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNoButton(context),
                const SizedBox(width: 16),
                _buildYesButton(context),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Expanded _buildYesButton(BuildContext context) {
    return Expanded(
      child: CustomButton(
        title: Text(
          'Да',
          style: AppFonts.s16w600.copyWith(
            color: Colors.white,
          ),
        ),
        onPressed: acceptTap,
        height: 54,
      ),
    );
  }

  Expanded _buildNoButton(BuildContext context) {
    return Expanded(
        child: OpacityButton(
      borderColor: AppColors.blue,
      onPressed: () {},
      title: 'Нет',
    ));
  }

  Text _exitTitle() {
    return Text(
      title,
      style: AppFonts.s24w600.copyWith(color: AppColors.black),
      textAlign: TextAlign.center,
    );
  }
}
