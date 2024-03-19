import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cafe_24/core/recources/app_colors.dart';
import 'package:neo_cafe_24/core/recources/app_fonts.dart';
import 'package:neo_cafe_24/core/recources/app_images.dart';
import 'package:neo_cafe_24/features/new_order_screen/domain/entity/table_entity.dart';
import 'package:neo_cafe_24/features/new_order_screen/presentation/view/new_order_screen/new_order_menu_screen.dart';
import 'package:neo_cafe_24/features/new_order_screen/presentation/view/table_new_order_screen/bloc/table_bloc.dart';
import 'package:neo_cafe_24/features/new_order_screen/presentation/widgets/info_row.dart';
import 'package:neo_cafe_24/features/notifications_screen/presentation/view/notifications_screen.dart';
import 'package:neo_cafe_24/features/profile/presentation/view/profile_screen.dart';
import 'package:neo_cafe_24/features/widgets/app_bar_button.dart';
import 'package:neo_cafe_24/features/widgets/custom_app_bar.dart';

class NewOrderTableScreen extends StatefulWidget {
  const NewOrderTableScreen({super.key});

  @override
  State<NewOrderTableScreen> createState() => _NewOrderTableScreenState();
}

class _NewOrderTableScreenState extends State<NewOrderTableScreen> {
  void goToCreateNewOrder(TableEntity table) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewOrderMenuScreen(
          table: table,
        ),
      ),
    );
  }

  @override
  void initState() {
    BlocProvider.of<TableBloc>(context).add(
      GetAllTablesEvent(),
    );
    super.initState();
  }

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
    return Stack(
      children: [
        Scaffold(
          appBar: _buildAppBar(),
          body: BlocBuilder<TableBloc, TableState>(
            builder: (context, state) {
              if (state is TableLoaded) {
                return _buildBody(context, childAspectRatio, state);
              }
              return const SizedBox();
            },
          ),
        ),
        _buildAppBarProfileTap(context),
        _buildNotificationButton(context),
      ],
    );
  }

  Padding _buildBody(
      BuildContext context, double childAspectRatio, TableLoaded state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          _tableNumberTitle(),
          const SizedBox(height: 24),
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
              itemBuilder: (BuildContext context, int index) {
                return TableContainer(
                  onTap: () {
                    goToCreateNewOrder(
                      state.tables[index],
                    );
                  },
                  tableNumber: state.tables[index].tableNumbe,
                  isAvailable: state.tables[index].isAvailable,
                );
              },
            ),
          ),
        ],
      ),
    );
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

  Text _tableNumberTitle() {
    return Text(
      'Выберите стол',
      style: AppFonts.s16w600.copyWith(
        color: AppColors.black,
      ),
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

class TableContainer extends StatelessWidget {
  final Function()? onTap;
  final int tableNumber;
  final bool isAvailable;

  const TableContainer(
      {super.key,
      required this.onTap,
      required this.tableNumber,
      required this.isAvailable});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            color: isAvailable ? AppColors.grey : AppColors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Center(
            child: Text(
              "$tableNumber",
              style: AppFonts.s48w400,
            ),
          ),
        ),
      ),
    );
  }
}
