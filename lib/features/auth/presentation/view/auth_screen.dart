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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text(
          'Вход',
          style: AppFonts.s32w600.copyWith(
            color: AppColors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 48),
            CustomTextField(
              hintText: 'Введите имя',
              prefixImage: AppImages.profileTap,
              controller: loginController,
            ),
            const SizedBox(height: 12),
            CustomTextField(
              hintText: 'Введите пароль',
              prefixImage: AppImages.lockIcon,
              controller: passwordController,
            ),
            const SizedBox(height: 56),
            CustomButton(
              title: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
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
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const CircularProgressIndicator();
                  }
                  return Text(
                    'Получить код',
                    style: AppFonts.s16w600.copyWith(
                      color: Colors.white,
                    ),
                  );
                },
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
                BlocProvider.of<AuthBloc>(context).add(
                  GetAuthEvent(
                    login: loginController.text,
                    password: passwordController.text,
                  ),
                );
              },
              height: 48,
            ),
          ],
        ),
      ),
    );
  }
}
