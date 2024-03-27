import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cafe_24/core/recources/app_colors.dart';
import 'package:neo_cafe_24/core/recources/app_fonts.dart';
import 'package:neo_cafe_24/core/recources/app_images.dart';
import 'package:neo_cafe_24/features/error_screen/error_screen.dart';
import 'package:neo_cafe_24/features/new_order_screen/presentation/view/table_new_order_screen/bloc/table_bloc.dart';
import 'package:neo_cafe_24/features/new_order_screen/presentation/view/table_new_order_screen/tables_new_order_screen.dart';
import 'package:neo_cafe_24/features/new_order_screen/presentation/widgets/info_row.dart';
import 'package:neo_cafe_24/features/notifications_screen/presentation/view/notifications_screen.dart';
import 'package:neo_cafe_24/features/order_info_screen/presentation/view/order_info_screen.dart';
import 'package:neo_cafe_24/features/order_screen/presentation/controller/bloc/all_orders_bloc.dart';
import 'package:neo_cafe_24/features/order_screen/presentation/widgets/toggle_button.dart';
import 'package:neo_cafe_24/features/profile/presentation/view/profile_screen.dart';
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
        [AppColors.orange],
      ];
  void _currentIndexTap(index) {
    currentIndex = index;
    setState(() {});
  }

  @override
  void initState() {
    BlocProvider.of<AllOrdersBloc>(context).add(
      GetAllOrders(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: _buildAppBar(),
          body: currentIndex == 0 ? const TablesBody() : const OrdersBody(),
        ),
        _buildAppBarProfileTap(context),
        _buildNotificationButton(context),
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
    return BlocConsumer<AllOrdersBloc, AllOrdersState>(
      listener: (context, state) {
        if (state is AllOrdersError) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ErrorScreen(),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is AllOrdersLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is AllOrdersLoaded) {
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
                      Color buttonColor = selectedIndex == index
                          ? AppColors.orange
                          : AppColors.grey;
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
                    itemCount: state.orders.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: OrderContainer(
                          status: state.orders[index].orderStatus,
                          createdAt: state.orders[index].createdAt,
                          orderNumber: state.orders[index].orderType,
                          tableNumber:
                              state.orders[index].table?.tableNumbe ?? 0,
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          );
        } else if (state is AllOrdersError) {
          return Center(
            child: Text(state.errorText),
          );
        }
        return const SizedBox();
      },
    );
  }
}

class OrderContainer extends StatelessWidget {
  final String status;
  final int tableNumber;
  final String orderNumber;
  final String createdAt;
  const OrderContainer({
    super.key,
    required this.status,
    required this.createdAt,
    required this.orderNumber,
    required this.tableNumber,
  });

  @override
  Widget build(BuildContext context) {
    Color getColorForStatus(String status) {
      switch (status) {
        case 'Новый':
          return Colors.lightBlue;
        case 'В процессе':
          return AppColors.yellow;
        case 'Завершен':
          return AppColors.green;
        default:
          return Colors.blue;
      }
    }

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
                  'Стол №$tableNumber',
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
                    color: getColorForStatus(status),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  status,
                  style: AppFonts.s16w400.copyWith(
                    color: AppColors.black,
                  ),
                ),
                const Spacer(),
                Text(
                  createdAt,
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
    double screenWidth = MediaQuery.of(context).size.width;
    double padding = 16.0 * 2;
    double spacing = 10.0;
    int crossAxisCount = 2;

    double totalSpacing = spacing * (crossAxisCount - 1) + padding;
    double itemWidth = (screenWidth - totalSpacing) / crossAxisCount;
    double itemHeight = 200.0;

    double childAspectRatio = itemWidth / itemHeight;
    return BlocConsumer<TableBloc, TableState>(
      listener: (context, state) {
        tableErrorState(state, context);
      },
      builder: (context, state) {
        if (state is TableLoaded) {
          return _tableLoadedState(childAspectRatio, state);
        } else if (state is TableLoading) {
          return loadingState();
        }
        return const SizedBox();
      },
    );
  }

  Padding _tableLoadedState(double childAspectRatio, TableLoaded state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 48),
          _buildInfoTablesRow(),
          const SizedBox(height: 32),
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                childAspectRatio: (childAspectRatio),
              ),
              itemCount: state.tables.length,
              itemBuilder: (BuildContext context, int index) =>
                  _buildTableContainer(state, index),
            ),
          ),
        ],
      ),
    );
  }

  TableContainer _buildTableContainer(TableLoaded state, int index) {
    return TableContainer(
      onTap: () => state.tables[index].isAvailable
          ? null
          : _goToTableOrderInfoScreen(state, index),
      tableNumber: state.tables[index].tableNumbe,
      isAvailable: state.tables[index].isAvailable,
    );
  }

  void _goToTableOrderInfoScreen(TableLoaded state, int index) {
    if (state.tables[index].isAvailable) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderInfoScreen(
            tableNumber: state.tables[index].tableNumbe,
          ),
        ),
      );
    } else {
      null;
    }
  }

  Center loadingState() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  void tableErrorState(TableState state, BuildContext context) {
    if (state is TableError) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ErrorScreen(),
        ),
      );
    }
  }
}

Row _buildInfoTablesRow() {
  return const Row(
    children: [
      InfoRow(
        color: AppColors.grey,
        name: 'Занято',
      ),
      SizedBox(width: 32),
      InfoRow(color: AppColors.green, name: 'Свободно')
    ],
  );
}
