import 'package:flutter/material.dart';
import 'package:neo_cafe_24/core/recources/app_colors.dart';
import 'package:neo_cafe_24/core/recources/app_fonts.dart';
import 'package:neo_cafe_24/core/recources/app_images.dart';
import 'package:neo_cafe_24/features/new_order_screen/presentation/view/new_order_menu_screen.dart';
import 'package:neo_cafe_24/features/widgets/app_bar_button.dart';
import 'package:neo_cafe_24/features/widgets/custom_app_bar.dart';

class NewOrderTableScreen extends StatefulWidget {
  const NewOrderTableScreen({super.key});

  @override
  State<NewOrderTableScreen> createState() => _NewOrderTableScreenState();
}

class _NewOrderTableScreenState extends State<NewOrderTableScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: _buildAppBar(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Text(
                  'Выберите стол',
                  style: AppFonts.s16w600.copyWith(
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 24),
                const Row(
                  children: [
                    InfoRow(
                      color: AppColors.grey,
                      name: 'Занято',
                    ),
                    SizedBox(width: 32),
                    InfoRow(color: AppColors.green, name: 'Свободно')
                  ],
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    TableContainer(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NewOrderMenuScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        _buildAppBarProfileTap(),
        _buildAppBarNotificationTap(),
      ],
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

Positioned _buildAppBarNotificationTap() {
  return Positioned(
    top: 65,
    right: 16,
    child: AppBarButton(
        color: AppColors.blue,
        icon: const Icon(
          Icons.notifications_none,
          color: Colors.white,
        ),
        onPressed: () {}),
  );
}

Positioned _buildAppBarProfileTap() {
  return Positioned(
    top: 65,
    left: 16,
    child: AppBarButton(
        color: AppColors.blue,
        icon: Image.asset(
          AppImages.profileTap,
          color: Colors.white,
        ),
        onPressed: () {}),
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

class InfoRow extends StatelessWidget {
  final Color color;
  final String name;
  const InfoRow({
    super.key,
    required this.color,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: ShapeDecoration(
            color: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          name,
          style: AppFonts.s14w400.copyWith(
            color: AppColors.black,
          ),
        )
      ],
    );
  }
}
