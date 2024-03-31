import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cafe_24/core/recources/app_colors.dart';
import 'package:neo_cafe_24/core/recources/app_fonts.dart';
import 'package:neo_cafe_24/features/auth/presentation/controller/auth_bloc/auth_bloc.dart';
import 'package:neo_cafe_24/features/home_page/presentation/home_page.dart';
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
  void sendCodeEvent() {
    context.read<AuthBloc>().state is AuthLoading
        ? null
        : BlocProvider.of<AuthBloc>(context).add(
            SendCodeEvent(
              code: codeController.text,
            ),
          );
  }

  void prevScreen() {
    Navigator.pop(context);
  }

  void goToNextScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfileScreen(),
      ),
    );
  }

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
    final errorPinTheme = PinTheme(
      width: 40,
      height: 52,
      textStyle: const TextStyle(
          fontSize: 20, color: Colors.red, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: AppColors.grey,
        border: Border.all(color: Colors.red),
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
          appBar: _buildAppBar(),
          body: _buildBody(
            defaultPinTheme,
            focusedPinTheme,
            submittedPinTheme,
            errorPinTheme,
            context,
          ),
        ),
        _buildArrowBackButton(context),
      ],
    );
  }

  Positioned _buildArrowBackButton(BuildContext context) {
    return Positioned(
      top: 64,
      left: 22,
      child: AppBarButton(
        color: AppColors.blue,
        icon: const Icon(
          Icons.arrow_back_ios_new,
          size: 16,
          color: Colors.white,
        ),
        onPressed: prevScreen,
      ),
    );
  }

  Center _buildBody(
      PinTheme defaultPinTheme,
      PinTheme focusedPinTheme,
      PinTheme submittedPinTheme,
      PinTheme errorPinTheme,
      BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 64),
            _buildTitle(codeController.text),
            const SizedBox(height: 16),
            _buildPinPut(defaultPinTheme, focusedPinTheme, submittedPinTheme,
                errorPinTheme),
            const SizedBox(height: 36),
            CustomButton(
              title: BlocConsumer<AuthBloc, AuthState>(
                listener: _authListener,
                builder: _authBuilder,
              ),
              onPressed: () {
                _sendCodeEvent(context);
              },
              height: 52,
            ),
          ],
        ),
      ),
    );
  }

  void _sendCodeEvent(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(
      SendCodeEvent(
        code: codeController.text,
      ),
    );
  }

  Widget _authBuilder(context, state) {
    if (state is AuthLoading) {
      return const CircularProgressIndicator();
    }
    return Text(
      'Подтвердить',
      style: AppFonts.s16w600.copyWith(
        color: Colors.white,
      ),
    );
  }

  void _authListener(context, state) {
    if (state is CodeLoaded) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (Route<dynamic> route) => false,
      );
    }
  }

  BlocBuilder _buildPinPut(PinTheme defaultPinTheme, PinTheme focusedPinTheme,
      PinTheme submittedPinTheme, PinTheme errorPinTheme) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        PinTheme currentPintTheme = defaultPinTheme;
        if (state is AuthError) {
          currentPintTheme = errorPinTheme;
        }

        return Pinput(
          cursor: Container(
            width: 20,
            height: 2,
            color: Colors.black,
            margin: const EdgeInsets.only(top: 30),
          ),
          defaultPinTheme: currentPintTheme,
          focusedPinTheme: focusedPinTheme,
          submittedPinTheme: submittedPinTheme,
          errorPinTheme: errorPinTheme,
          controller: codeController,
          pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
          showCursor: true,
        );
      },
    );
  }

  BlocBuilder _buildTitle(String controller) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthError) {
          return Text(
            'Код введен не верно\nпопробуйте еще раз',
            textAlign: TextAlign.center,
            style: AppFonts.s16w600.copyWith(
              color: Colors.red,
            ),
          );
        }
        return Text(
          'Введите 4-х значный код,\n отправленный на почту\n${widget.email}',
          textAlign: TextAlign.center,
          style: AppFonts.s16w600,
        );
      },
    );
  }

  MyAppBar _buildAppBar() {
    return MyAppBar(
      title: Text(
        'Код подтверждения',
        style: AppFonts.s20w600.copyWith(
          color: AppColors.black,
        ),
      ),
    );
  }
}
