part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final ProfileEntity profile;

  ProfileLoaded({required this.profile});
}

final class ProfileError extends ProfileState {
  final String errorText;

  ProfileError({required this.errorText});
}
