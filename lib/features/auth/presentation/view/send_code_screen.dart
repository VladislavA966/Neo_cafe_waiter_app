import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cafe_24/core/recources/app_colors.dart';
import 'package:neo_cafe_24/core/recources/app_fonts.dart';
import 'package:neo_cafe_24/features/auth/presentation/controller/auth_bloc/auth_bloc.dart';
import 'package:neo_cafe_24/features/home_page/presentation/home_page.dart';
import 'package:neo_cafe_24/features/menu_screen/presentation/view/menu_screen.dart';
import 'package:neo_cafe_24/features/profile/presentation/view/profile_screen.dart';
import 'package:neo_cafe_24/features/widgets/app_bar_button.dart';
import 'package:neo_cafe_24/features/widgets/custom_app_bar.dart';
import 'package:neo_cafe_24/features/widgets/custom_button.dart';
import 'package:pinput/pinput.dart';

class SendCodeScreen extends StatefulWidget {
  final String email;
  const SendCodeScreen({super.key, required this.email});

  @override
  State<SendCodeScreen> createState() => _SendCodeScreenState();
}

class _SendCodeScreenState extends State<SendCodeScreen> {
  final codeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 40,
      height: 52,
      textStyle: const TextStyle(
          fontSize: 20, color: AppColors.black, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: AppColors.grey,
        border: Border.all(color: AppColors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(
        color: AppColors.grey,
      ),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: AppColors.grey,
      ),
    );
    return Stack(
      children: [
        Scaffold(
          appBar: MyAppBar(
            title: Text(
              'Код подтверждения',
              style: AppFonts.s20w600.copyWith(
                color: AppColors.black,
              ),
            ),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 64),
                  Text(
                    'Введите 4-х значный код,\n отправленный на почту\n${widget.email}',
                    textAlign: TextAlign.center,
                    style: AppFonts.s16w600,
                  ),
                  const SizedBox(height: 16),
                  Pinput(
                    cursor: Container(
                      width: 20,
                      height: 2,
                      color: Colors.black,
                      margin: const EdgeInsets.only(top: 30),
                    ),
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: submittedPinTheme,
                    controller: codeController,
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    showCursor: true,
                    onCompleted: (pin) => print(pin),
                  ),
                  const SizedBox(height: 36),
                  CustomButton(
                    title: BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is CodeLoaded) {}
                      },
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          return const CircularProgressIndicator();
                        }
                        return Text(
                          'Подтвердить',
                          style: AppFonts.s16w600.copyWith(
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                      // final Dio dio = Dio();
                      // await dio.post(
                      //     'https://tokyo-backender.org.kg/waiter/login/',
                      //     data: {
                      //       "email": "vlad@vlad.com",
                      //       "confirmation_code": "4444"
                      //     });
                      BlocProvider.of<AuthBloc>(context).add(
                        SendCodeEvent(
                          code: codeController.text,
                        ),
                      );
                    },
                    height: 52,
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 64,
          left: 22,
          child: AppBarButton(
            color: AppColors.blue,
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: 16,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
