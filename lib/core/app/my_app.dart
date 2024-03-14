import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neo_cafe_24/core/di/dependency_injection.dart';
import 'package:neo_cafe_24/core/recources/app_colors.dart';
import 'package:neo_cafe_24/features/auth/domain/use_case/auth_use_case.dart';
import 'package:neo_cafe_24/features/auth/domain/use_case/send_code_use_case.dart';
import 'package:neo_cafe_24/features/auth/presentation/controller/auth_bloc/auth_bloc.dart';
import 'package:neo_cafe_24/features/auth/presentation/view/auth_screen.dart';
import 'package:neo_cafe_24/features/menu_screen/domain/use_cases/category_use_case.dart';
import 'package:neo_cafe_24/features/menu_screen/domain/use_cases/menu_items_use_case.dart';
import 'package:neo_cafe_24/features/menu_screen/presentation/controller/category_bloc/category_bloc.dart';
import 'package:neo_cafe_24/features/menu_screen/presentation/controller/menu_item/menu_item_bloc.dart';
import 'package:neo_cafe_24/features/new_order_screen/domain/use_case/cart_use_case.dart';
import 'package:neo_cafe_24/features/new_order_screen/domain/use_case/order_use_case.dart';
import 'package:neo_cafe_24/features/new_order_screen/presentation/controller/cart_bloc/cart_bloc.dart';
import 'package:neo_cafe_24/features/new_order_screen/presentation/controller/new_order_bloc/new_order_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            getIt<AuthUseCase>(),
            getIt<SendCodeUseCase>(),
          ),
        ),
        BlocProvider(
          create: (context) => CategoryBloc(
            getIt<CategoryUseCase>(),
          ),
        ),
        BlocProvider(
          create: (context) => MenuItemBloc(
            getIt<AllItemsUseCase>(),
          ),
        ),
        BlocProvider(
          create: (context) => CartBloc(
            cartUseCase: getIt<CartUseCase>(),
          ),
        ),
        BlocProvider(
          create: (context) => NewOrderBloc(
            getIt<NewOrderUseCase>(),
          ),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
          appBarTheme: const AppBarTheme(
            color: AppColors.textWhite,
          ),
        ),
        home: const AuthScreen(),
      ),
    );
  }
}
