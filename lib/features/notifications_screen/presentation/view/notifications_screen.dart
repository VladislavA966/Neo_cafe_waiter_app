import 'package:flutter/material.dart';
import 'package:neo_cafe_24/core/recources/app_colors.dart';
import 'package:neo_cafe_24/core/recources/app_fonts.dart';
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
          appBar: MyAppBar(
            title: Text(
              'Уведомления',
              style: AppFonts.s24w600.copyWith(
                color: AppColors.black,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 24),
                TextButton(
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
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: buildNotifications,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 65,
          left: 16,
          child: AppBarButton(
              color: AppColors.blue,
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ),
              onPressed: navigatorPop),
        ),
      ],
    );
  }
}

class NotificationContainer extends StatelessWidget {
  const NotificationContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.black,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Заказ готов',
                    style: AppFonts.s16w600.copyWith(
                      color: AppColors.orange,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '19:02',
                    style: AppFonts.s16w600.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
              Text(
                'Капучино x1, Американо x2, Багровай за...',
                style: AppFonts.s14w400.copyWith(color: AppColors.black),
              )
            ],
          ),
        ),
      ),
    );
  }
}
