part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

final class GetProfileInfoEvent extends ProfileEvent {}
