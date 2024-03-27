import 'package:flutter/material.dart';
import 'package:neo_cafe_24/core/recources/app_colors.dart';
import 'package:neo_cafe_24/core/recources/app_images.dart';
import 'package:neo_cafe_24/features/menu_screen/presentation/view/menu_screen.dart';
import 'package:neo_cafe_24/features/new_order_screen/presentation/view/table_new_order_screen/tables_new_order_screen.dart';
import 'package:neo_cafe_24/features/order_screen/presentation/pages/orders_screen.dart';

class HomePage extends StatefulWidget {
  final int initialIndex;
  const HomePage({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int _selectedIndex;
  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  final List<Widget> _widgetOptions = [
    const OrdersScreen(),
    const NewOrderTableScreen(),
    const MenuScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<BoxShadow> get shadows => const [
        BoxShadow(
          color: Color(0x14000000),
          blurRadius: 4,
          offset: Offset(0, -2),
          spreadRadius: 0,
        ),
        BoxShadow(
          color: Color(0x05000000),
          blurRadius: 6,
          offset: Offset(0, 0),
          spreadRadius: 0,
        )
      ];
  List<BottomNavigationBarItem> get items => <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Image.asset(AppImages.orderTap),
          activeIcon: Image.asset(
            AppImages.selecterOrderTap,
            color: AppColors.blue,
          ),
          label: 'Заказы',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            AppImages.newOrderTap,
          ),
          activeIcon: Image.asset(
            AppImages.selectedNewOrderTap,
            color: AppColors.blue,
          ),
          label: 'Новый заказ',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(AppImages.menuTap),
          activeIcon: Image.asset(
            AppImages.selectedMenuTap,
            color: AppColors.blue,
          ),
          label: 'Меню',
        ),
      ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: shadows,
          borderRadius: BorderRadius.circular(40),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.blue,
            selectedIconTheme: const IconThemeData(
              color: AppColors.orange,
            ),
            items: items,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
