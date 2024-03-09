import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cafe_24/core/recources/app_colors.dart';
import 'package:neo_cafe_24/core/recources/app_fonts.dart';
import 'package:neo_cafe_24/core/recources/app_images.dart';
import 'package:neo_cafe_24/features/menu_screen/presentation/controller/category_bloc/category_bloc.dart';
import 'package:neo_cafe_24/features/menu_screen/presentation/controller/menu_item/menu_item_bloc.dart';
import 'package:neo_cafe_24/features/notifications_screen/presentation/view/notifications_screen.dart';
import 'package:neo_cafe_24/features/order_screen/presentation/widgets/toggle_button.dart';
import 'package:neo_cafe_24/features/profile/presentation/view/profile_screen.dart';
import 'package:neo_cafe_24/features/shopping_cart_screen.dart/presentation/controller/bloc/cart_bloc.dart';
import 'package:neo_cafe_24/features/widgets/app_bar_button.dart';
import 'package:neo_cafe_24/features/widgets/custom_app_bar.dart';
import 'package:neo_cafe_24/features/widgets/search_field.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int selectedId = 1;
  @override
  void initState() {
    selectedId = selectedId;
    BlocProvider.of<CategoryBloc>(context).add(
      GetAllCategoriesEvent(),
    );
    BlocProvider.of<MenuItemBloc>(context).add(
      GetAllItemsEvent(id: selectedId),
    );
    BlocProvider.of<CartBloc>(context).add(CartStarted());

    super.initState();
  }

  final controller = TextEditingController();
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
        Scaffold(
          appBar: _buildAppBar(),
          body: _buildBody(),
        ),
        _buildNotificationButton(context),
        _buildAppBarProfileTap(context),
        SearchField(
          controller: controller,
        )
      ],
    );
  }

  Padding _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 48),
          _buildCategoriesList(),
          const SizedBox(height: 16),
          BlocBuilder<MenuItemBloc, MenuItemState>(
            builder: (context, state) {
              if (state is MenuItemLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is MenuItemLoaded) {
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.model.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: MenuContainer(
                          name: state.model[index].name,
                          price: state.model[index].pricePerUnit),
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }

  BlocBuilder<CategoryBloc, CategoryState> _buildCategoriesList() {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
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
                Color buttonColor = selectedId == categoryId
                    ? AppColors.orange
                    : AppColors.grey;
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
      },
    );
  }
}

class MenuContainer extends StatelessWidget {
  final String name;
  final int price;
  const MenuContainer({
    super.key,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      padding: const EdgeInsets.only(
        top: 19,
        left: 16,
        right: 16,
        bottom: 18,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 8,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 4,
            offset: Offset(0, 0),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: AppFonts.s16w600.copyWith(
              color: AppColors.black,
            ),
          ),
          Text(
            '$price c',
            style: AppFonts.s16w600.copyWith(color: AppColors.blue),
          )
        ],
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
              builder: (context) => NotificationsScreen(),
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
      'Меню',
      style: AppFonts.s24w600.copyWith(
        color: AppColors.black,
      ),
    ),
  );
}
