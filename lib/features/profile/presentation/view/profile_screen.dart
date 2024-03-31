import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cafe_24/core/di/dependency_injection.dart';
import 'package:neo_cafe_24/core/recources/app_colors.dart';
import 'package:neo_cafe_24/core/recources/app_fonts.dart';
import 'package:neo_cafe_24/core/recources/app_images.dart';
import 'package:neo_cafe_24/features/auth/data/data_source/local_data_source/local_data_source.dart';
import 'package:neo_cafe_24/features/auth/presentation/view/auth_screen.dart';
import 'package:neo_cafe_24/features/new_order_screen/presentation/controller/cart_bloc/cart_bloc.dart';
import 'package:neo_cafe_24/features/profile/presentation/view/bloc/profile_bloc.dart';
import 'package:neo_cafe_24/features/profile/presentation/widgets/log_out_dialog.dart';
import 'package:neo_cafe_24/features/widgets/app_bar_button.dart';
import 'package:neo_cafe_24/features/widgets/auth_text_field.dart';
import 'package:neo_cafe_24/features/widgets/custom_app_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void showLogOutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return LogountModalWindow(
          acceptTap: () => _acceptTap(context),
          title: 'Уверены, что хотите\nвыйти?',
          declineTap: () => Navigator.pop(context),
        );
      },
    );
  }

  final authData = getIt<AuthDataSource>();

  void _acceptTap(BuildContext context) {
    authData.clearAllUserData();
    BlocProvider.of<CartBloc>(context).add(
      CleanCartEvent(),
    );
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const AuthScreen(),
      ),
      (Route<dynamic> route) => false,
    );
  }

  void navigatorPop() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    BlocProvider.of<ProfileBloc>(context).add(
      GetProfileInfoEvent(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: _buildAppBar(),
          body: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return _buildProfileLoadingState();
              } else if (state is ProfileLoaded) {
                return _buildBody(state);
              }
              return const SizedBox();
            },
          ),
        ),
        _buildArrowBackButton(context),
        _buildLogoutButton(context)
      ],
    );
  }

  Center _buildProfileLoadingState() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Padding _buildBody(ProfileLoaded state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 48),
          _buildNameTitle(),
          _buildName(state),
          const SizedBox(height: 40),
          _buildWorkingTime(),
          const SizedBox(height: 20),
          _scheduleListViewBuilder(state),
        ],
      ),
    );
  }

  Expanded _scheduleListViewBuilder(ProfileLoaded state) {
    return Expanded(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: state.profile.employeeSchedules.length,
        itemBuilder: (context, index) {
          return _buildSchedule(state, index);
        },
      ),
    );
  }

  Text _buildSchedule(ProfileLoaded state, int index) {
    return Text(
      '${state.profile.employeeSchedules[index].day}: ${state.profile.employeeSchedules[index].startTime} - ${state.profile.employeeSchedules[index].endTime}',
      style: AppFonts.s16w400.copyWith(
        color: AppColors.black,
      ),
    );
  }

  Center _buildWorkingTime() {
    return Center(
      child: Text(
        'График работы',
        style: AppFonts.s24w600.copyWith(
          color: AppColors.black,
        ),
      ),
    );
  }

  CustomTextField _buildName(ProfileLoaded state) {
    return CustomTextField(
      hintText: state.profile.firstName,
      enabled: false,
      prefixImage: AppImages.profileTap,
      controller: TextEditingController(),
    );
  }

  Text _buildNameTitle() {
    return Text(
      'Имя',
      style: AppFonts.s16w400.copyWith(color: AppColors.blue),
    );
  }

  MyAppBar _buildAppBar() {
    return MyAppBar(
      title: Text(
        'Профиль',
        style: AppFonts.s24w600.copyWith(color: AppColors.black),
      ),
    );
  }

  Positioned _buildLogoutButton(BuildContext context) {
    return Positioned(
      top: 64,
      right: 22,
      child: AppBarButton(
          color: AppColors.blue,
          icon: Image.asset(
            AppImages.logoutIcon,
          ),
          onPressed: showLogOutDialog),
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
        onPressed: navigatorPop,
      ),
    );
  }
}
