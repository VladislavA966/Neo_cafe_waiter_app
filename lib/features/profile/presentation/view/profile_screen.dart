import 'package:flutter/material.dart';
import 'package:neo_cafe_24/core/recources/app_colors.dart';
import 'package:neo_cafe_24/core/recources/app_fonts.dart';
import 'package:neo_cafe_24/core/recources/app_images.dart';
import 'package:neo_cafe_24/features/profile/presentation/widgets/log_out_dialog.dart';
import 'package:neo_cafe_24/features/widgets/app_bar_button.dart';
import 'package:neo_cafe_24/features/widgets/auth_text_field.dart';
import 'package:neo_cafe_24/features/widgets/custom_app_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<CustomRow> rows = const [
    CustomRow(image: AppImages.dayImage, title: 'Дневная смена'),
    CustomRow(image: AppImages.night, title: 'Ночная смена'),
    CustomRow(image: AppImages.minus, title: 'Выходной'),
  ];
  void showLogOutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return const LogountModalWindow();
      },
    );
  }

  void navigatorPop() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: MyAppBar(
            title: Text(
              'Профиль',
              style: AppFonts.s24w600.copyWith(color: AppColors.black),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 48),
                Text(
                  'Имя',
                  style: AppFonts.s16w400.copyWith(color: AppColors.blue),
                ),
                CustomTextField(
                  hintText: 'Алихандро',
                  prefixImage: AppImages.profileTap,
                  controller: TextEditingController(),
                ),
                const SizedBox(height: 40),
                Center(
                  child: Text(
                    'График работы',
                    style: AppFonts.s24w600.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: rows.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: rows[index],
                        );
                      }),
                )
              ],
            ),
          ),
        ),
        _buildArrowBackButton(context),
        _buildLogoutButton(context)
      ],
    );
  }

  Positioned _buildLogoutButton(BuildContext context) {
    return Positioned(
      top: 64,
      right: 22,
      child: AppBarButton(
          color: AppColors.blue,
          icon: Image.asset(
            AppImages.logoutIcon,
          ),
          onPressed: showLogOutDialog),
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
        onPressed: navigatorPop,
      ),
    );
  }
}

class CustomRow extends StatelessWidget {
  final String image;
  final String title;
  const CustomRow({
    super.key,
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(image),
        const SizedBox(width: 10),
        Text(
          title,
          style: AppFonts.s16w500,
        )
      ],
    );
  }
}
