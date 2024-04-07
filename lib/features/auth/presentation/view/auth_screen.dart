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
  String? loginError;
  String? passwordError;
  String? errorText;
  String _loginHint = 'Введите имя';
  String _passwordHint = 'Введите пароль';

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
      onPressed: () => authEvent(),
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
    } else if (state is LoginValidationError) {
      loginError = state.errorText;
      setState(() {});
    } else if (state is PasswordValidationError) {
      passwordError = state.errorText;
      setState(() {});
    } else if (state is AuthError) {
      errorText = '';
      _loginHint = 'Неверный логин или пароль';
      _passwordHint = 'Неверный логин или пароль';
      loginController.text = '';
      passwordController.text = '';
      setState(() {});
    }
  }

  CustomTextField _buildPasswordTextField() {
    return CustomTextField(
      hintText: _passwordHint,
      prefixImage: AppImages.lockIcon,
      controller: passwordController,
      errorText: errorText,
    );
  }

  CustomTextField _buildNameTextField() {
    return CustomTextField(
      keyboardType: TextInputType.emailAddress,
      errorText: errorText,
      hintText: _loginHint,
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
