import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cafe_24/core/recources/app_colors.dart';
import 'package:neo_cafe_24/core/recources/app_fonts.dart';
import 'package:neo_cafe_24/features/menu_screen/presentation/controller/category_bloc/category_bloc.dart';
import 'package:neo_cafe_24/features/menu_screen/presentation/controller/menu_item/menu_item_bloc.dart';
import 'package:neo_cafe_24/features/new_order_screen/domain/entity/table_entity.dart';
import 'package:neo_cafe_24/features/new_order_screen/presentation/controller/cart_bloc/cart_bloc.dart';
import 'package:neo_cafe_24/features/new_order_screen/presentation/widgets/order_summary_modal.dart';
import 'package:neo_cafe_24/features/order_screen/presentation/widgets/new_order_menu_container.dart';
import 'package:neo_cafe_24/features/order_screen/presentation/widgets/toggle_button.dart';
import 'package:neo_cafe_24/features/new_order_screen/domain/entity/cart_item_entity.dart';
import 'package:neo_cafe_24/features/widgets/app_bar_button.dart';
import 'package:neo_cafe_24/features/widgets/custom_app_bar.dart';
import 'package:neo_cafe_24/features/widgets/custom_button.dart';
import 'package:neo_cafe_24/features/widgets/search_field.dart';

class NewOrderMenuScreen extends StatefulWidget {
  final TableEntity table;
  const NewOrderMenuScreen({super.key, required this.table});

  @override
  State<NewOrderMenuScreen> createState() => _NewOrderMenuScreenState();
}

class _NewOrderMenuScreenState extends State<NewOrderMenuScreen> {
  int selectedId = 1;
  @override
  void initState() {
    selectedId = selectedId;
    BlocProvider.of<CategoryBloc>(context).add(
      GetAllCategoriesEvent(),
    );

    super.initState();
  }

  double calculateTotal(CartLoadSuccess state) {
    double total = 0;
    for (var item in state.items) {
      total += item.price * item.quantity;
    }
    return total;
  }

  final controller = TextEditingController();

  removeItemFromCart(int itemId) {
    context.read<CartBloc>().add(CartItemRemoved(itemId));
  }

  void addItemToCart(
      int id, String name, String image, int price, int quantity) {
    context.read<CartBloc>().add(
          CartItemAdded(
            CartItemEntity(
              id: id,
              name: name,
              image: image,
              price: price,
              quantity: quantity,
            ),
          ),
        );
  }

  void _onCategorySelected(int id) {
    setState(() {
      selectedId = id;
    });
    BlocProvider.of<MenuItemBloc>(context).add(GetAllItemsEvent(id: id));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<MenuItemBloc, MenuItemState>(
          builder: _menuItemBuilder,
        ),
        _buildAppBarProfileTap(context),
        SearchField(
          controller: controller,
        )
      ],
    );
  }

  Widget _menuItemBuilder(context, state) {
    if (state is MenuItemLoaded) {
      return Scaffold(
        appBar: _buildAppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _buildBody(state),
        ),
      );
    } else if (state is MenuItemLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return const SizedBox();
  }

  Column _buildBody(MenuItemLoaded state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 48),
        _buildTableNumberTitle(),
        const SizedBox(height: 20),
        _buildButtonsList(),
        const SizedBox(height: 16),
        _buildButtonMenuList(state),
        _buildSummaryButton()
      ],
    );
  }

  BlocBuilder _buildSummaryButton() {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoadSuccess) {
          double total = calculateTotal(state);
          if (state.items.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: CustomButton(
                color: AppColors.orange,
                onPressed: () {
                  orderModal(context);
                },
                height: 56,
                orderTitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildOrderNumberTitle(),
                    _buildSummaryPrice(total)
                  ],
                ),
              ),
            );
          }
        }
        return const SizedBox();
      },
    );
  }

  Text _buildSummaryPrice(double total) {
    return Text(
      '$total сом',
      style: AppFonts.s16w600.copyWith(
        color: Colors.white,
      ),
    );
  }

  Text _buildOrderNumberTitle() {
    return Text(
      'Заказ №1',
      style: AppFonts.s16w600.copyWith(color: Colors.white),
    );
  }

  Future<dynamic> orderModal(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => OrderSummaryModal(
        table: widget.table,
      ),
    );
  }

  Expanded _buildButtonMenuList(MenuItemLoaded state) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: state.model.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: NewOrderMenuContainer(
            iconButton: _buildIconButton(
              context,
              state.model[index].id,
              state.model[index].name,
              state.model[index].itemImage,
              state.model[index].pricePerUnit,
            ),
            name: state.model[index].name,
            price: state.model[index].pricePerUnit,
          ),
        ),
      ),
    );
  }

  BlocBuilder _buildIconButton(
      BuildContext context, int id, String name, String image, int price) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoadSuccess) {
          final currentItem =
              state.items.firstWhereOrNull((item) => item.id == id);
          final itemCount = currentItem?.quantity ?? 0;
          return GestureDetector(
            onTap: () {
              if (itemCount == 0) {
                addItemToCart(id, name, image, price, 1);
              } else {
                removeItemFromCart(currentItem?.id ?? 1);
              }
            },
            child: Icon(
              itemCount == 0 ? Icons.add : Icons.remove,
              color: AppColors.blue,
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  Text _buildTableNumberTitle() {
    return Text(
      'Стол №${widget.table.tableNumbe}',
      style: AppFonts.s16w600.copyWith(
        color: AppColors.black,
      ),
    );
  }

  BlocBuilder<CategoryBloc, CategoryState> _buildButtonsList() {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: _categoryList,
    );
  }

  Widget _categoryList(context, state) {
    if (state is CategoryAllLoaded) {
      return SizedBox(
        height: 38,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: state.model.length,
          itemBuilder: (context, index) {
            final categoryId = state.model[index].id;
            Color textColor =
                selectedId == categoryId ? Colors.white : Colors.black;
            Color buttonColor =
                selectedId == categoryId ? AppColors.orange : AppColors.grey;
            return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () {
                  _onCategorySelected(categoryId);
                },
                child: ToggleButton(
                  textColor: textColor,
                  buttonColor: buttonColor,
                  name: state.model[index].name,
                ),
              ),
            );
          },
        ),
      );
    } else if (state is CategoryAllError) {
      Text(state.errorText);
    }
    return const SizedBox();
  }
}

Positioned _buildAppBarProfileTap(BuildContext context) {
  return Positioned(
    top: 65,
    left: 16,
    child: AppBarButton(
        color: AppColors.blue,
        icon: const Icon(
          Icons.arrow_back_ios_new_outlined,
          color: AppColors.textWhite,
        ),
        onPressed: () {
          Navigator.pop(context);
        }),
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
