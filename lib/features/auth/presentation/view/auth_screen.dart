import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cafe_24/core/recources/app_colors.dart';
import 'package:neo_cafe_24/core/recources/app_fonts.dart';
import 'package:neo_cafe_24/core/recources/app_images.dart';
import 'package:neo_cafe_24/features/auth/presentation/controller/auth_bloc/auth_bloc.dart';
import 'package:neo_cafe_24/features/auth/presentation/view/send_code_screen.dart';
import 'package:neo_cafe_24/features/widgets/auth_text_field.dart';
import 'package:neo_cafe_24/features/widgets/custom_app_bar.dart';
import 'package:neo_cafe_24/features/widgets/custom_button.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final loginController = TextEditingController();
  final passwordController = TextEditingController();
  void authEvent() {
    context.read<AuthBloc>().state is AuthLoading
        ? null
        : BlocProvider.of<AuthBloc>(context).add(
            GetAuthEvent(
              login: loginController.text,
              password: passwordController.text,
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  Padding _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 48),
          _buildNameTextField(),
          const SizedBox(height: 12),
          _buildPasswordTextField(),
          const SizedBox(height: 56),
          _buildCustomButton(context),
        ],
      ),
    );
  }

  CustomButton _buildCustomButton(BuildContext context) {
    return CustomButton(
      title: BlocConsumer<AuthBloc, AuthState>(
        listener: _authListener,
        builder: _authBuilder,
      ),
      onPressed: () {
        // final Dio dio = Dio();
        // final responce = await dio.post(
        //   'https://tokyo-backender.org.kg/waiter/check-username-login/',
        //   data: {
        //     "username": "vlad@vlad.com",
        //     "password": "4444",
        //   },
        // );
        // if (responce.statusCode == 200 || responce.statusCode == 201) {
        //   print('object');
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => SendCodeScreen(
        //         email: "",
        //       ),
        //     ),
        //   );
        // }
        authEvent();
      },
      height: 48,
    );
  }

  Widget _authBuilder(context, state) {
    if (state is AuthLoading) {
      return const CircularProgressIndicator();
    }
    return Text(
      'Получить код',
      style: AppFonts.s16w600.copyWith(
        color: Colors.white,
      ),
    );
  }

  void _authListener(context, state) {
    if (state is AuthLoaded) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SendCodeScreen(
            email: state.email,
          ),
        ),
      );
    }
  }

  CustomTextField _buildPasswordTextField() {
    return CustomTextField(
      hintText: 'Введите пароль',
      prefixImage: AppImages.lockIcon,
      controller: passwordController,
    );
  }

  CustomTextField _buildNameTextField() {
    return CustomTextField(
      hintText: 'Введите имя',
      prefixImage: AppImages.profileTap,
      controller: loginController,
    );
  }

  MyAppBar _buildAppBar() {
    return MyAppBar(
      title: Text(
        'Вход',
        style: AppFonts.s32w600.copyWith(
          color: AppColors.black,
        ),
      ),
    );
  }
}
