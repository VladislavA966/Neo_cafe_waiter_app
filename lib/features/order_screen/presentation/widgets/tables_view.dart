import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cafe_24/core/recources/app_colors.dart';
import 'package:neo_cafe_24/features/error_screen/error_screen.dart';
import 'package:neo_cafe_24/features/new_order_screen/presentation/view/table_new_order_screen/bloc/table_bloc.dart';
import 'package:neo_cafe_24/features/new_order_screen/presentation/widgets/info_row.dart';
import 'package:neo_cafe_24/features/new_order_screen/presentation/widgets/table_container.dart';
import 'package:neo_cafe_24/features/order_info_screen/presentation/view/order_info_screen.dart';

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
      onTap: () => _goToTableOrderInfoScreen(state, index, context),
      tableNumber: state.tables[index].tableNumbe,
      isAvailable: state.tables[index].isAvailable,
    );
  }

  Center loadingState() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

void _goToTableOrderInfoScreen(
    TableLoaded state, int index, BuildContext context) {
  if (!state.tables[index].isAvailable) {
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
