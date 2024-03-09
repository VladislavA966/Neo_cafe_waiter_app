import 'package:flutter/material.dart';
import 'package:neo_cafe_24/core/recources/app_colors.dart';
import 'package:neo_cafe_24/core/recources/app_fonts.dart';
import 'package:neo_cafe_24/core/recources/app_images.dart';
import 'package:neo_cafe_24/features/order_screen/presentation/widgets/toggle_button.dart';
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
        [AppColors.orange]
      ];
  void _currentIndexTap(index) {
    currentIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: _buildAppBar(),
          body: currentIndex == 0 ? const TablesBody() : const OrdersBody(),
        ),
        _buildAppBarProfileTap(),
        _buildAppBarArrowBackTap(),
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

  Positioned _buildAppBarArrowBackTap() {
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

class OrdersBody extends StatefulWidget {
  const OrdersBody({super.key});

  @override
  State<OrdersBody> createState() => _OrdersBodyState();
}

class _OrdersBodyState extends State<OrdersBody> {
  List<String> buttonNames = ['Все', 'Новые', 'В процессе', 'Готово'];
  int? selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 48),
          SizedBox(
            height: 38,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: buttonNames.length,
              itemBuilder: (context, index) {
                Color textColor =
                    selectedIndex == index ? Colors.white : Colors.black;
                Color buttonColor =
                    selectedIndex == index ? AppColors.orange : AppColors.grey;
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () {
                      selectedIndex = index;
                      setState(() {});
                    },
                    child: ToggleButton(
                      textColor: textColor,
                      buttonColor: buttonColor,
                      name: buttonNames[index],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: OrderContainer(),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class OrderContainer extends StatelessWidget {
  const OrderContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.grey,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Стол №1',
                  style: AppFonts.s20w600.copyWith(
                    color: AppColors.black,
                  ),
                ),
                const Spacer(),
                Text(
                  '№23144',
                  style: AppFonts.s16w500.copyWith(
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: ShapeDecoration(
                    color: AppColors.yellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'В процессе',
                  style: AppFonts.s16w400.copyWith(
                    color: AppColors.black,
                  ),
                ),
                const Spacer(),
                Text(
                  '19:02',
                  style: AppFonts.s16w600.copyWith(
                    color: AppColors.black,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class TablesBody extends StatefulWidget {
  const TablesBody({super.key});

  @override
  State<TablesBody> createState() => _TablesBodyState();
}

class _TablesBodyState extends State<TablesBody> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
