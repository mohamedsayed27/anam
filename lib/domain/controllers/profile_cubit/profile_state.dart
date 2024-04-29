import 'dart:io';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class LoginStatus extends ProfileState {}

class LogoutStatus extends ProfileState {}

class LoadingState extends ProfileState {}

class SuccessState extends ProfileState {}

class ErrorState extends ProfileState {}

class ShowProfileLoadingState extends ProfileState {}

class ShowProfileSuccessState extends ProfileState {}

class ShowProfileErrorState extends ProfileState {
  final String error;

  ShowProfileErrorState({required this.error});
}

class GetNotificationsLoadingState extends ProfileState {}

class GetNotificationsSuccessState extends ProfileState {}

class GetNotificationsErrorState extends ProfileState {
  final String error;

  GetNotificationsErrorState({required this.error});
}

class GetUserFollowingLoadingState extends ProfileState {}

class GetUserFollowingSuccessState extends ProfileState {}

class GetUserFollowingErrorState extends ProfileState {
  final String error;

  GetUserFollowingErrorState({required this.error});
}

class GetVendorFollowingLoadingState extends ProfileState {}

class GetVendorFollowingSuccessState extends ProfileState {}

class GetVendorFollowingErrorState extends ProfileState {
  final String error;

  GetVendorFollowingErrorState({required this.error});
}

class ShowVendorProfileLoadingState extends ProfileState {}

class ShowVendorProfileSuccessState extends ProfileState {}

class ShowVendorProfileErrorState extends ProfileState {
  final String error;

  ShowVendorProfileErrorState({required this.error});
}

class UpdateProfileLoadingState extends ProfileState {}

class UpdateProfileSuccessState extends ProfileState {
  UpdateProfileSuccessState();
}

class UpdateProfileErrorState extends ProfileState {
  final String error;

  UpdateProfileErrorState({required this.error});
}

class UpdatePasswordLoadingState extends ProfileState {}

class GetPickedImageErrorState extends ProfileState {}

class UpdatePasswordSuccessState extends ProfileState {}

class UpdatePasswordErrorState extends ProfileState {
  final String error;

  UpdatePasswordErrorState({
    required this.error,
  });
}

class GetPickedImageSuccessState extends ProfileState {
  GetPickedImageSuccessState();
}
