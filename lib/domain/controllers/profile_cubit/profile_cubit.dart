import 'dart:io';

import 'package:anam/core/constants/constants.dart';
import 'package:anam/core/parameters/change_password_parameters.dart';
import 'package:anam/core/parameters/update_profile_parameters.dart';
import 'package:anam/data/datasources/remote_datasource/auth_remote_datasource.dart';
import 'package:anam/data/datasources/remote_datasource/profile_remote_datasource.dart';
import 'package:anam/data/models/base_model.dart';
import 'package:anam/data/models/notification/notification_model.dart';
import 'package:anam/data/models/user_model/profile_model.dart';
import 'package:anam/data/models/vendor_data_model.dart';
import 'package:anam/data/models/vendor_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/network/error_message_model.dart';
import '../../../core/services/services_locator.dart';
import '../../../data/models/user_model/user_data_model.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);
  final ProfileRemoteDatasource profileRemoteDatasource = sl();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  ProfileModel? profileModel;
  VendorProfileModel? vendorProfileModel;
  BaseErrorModel? baseErrorModel;
  BaseResponseModel? baseResponseModel;
  bool isLoggedIn = true;
  File? profileImage;

  final _picker = ImagePicker();

  Future<void> getImagePick() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(GetPickedImageSuccessState());
    } else {
      emit(GetPickedImageErrorState());
    }
  }

  void logout() {
    isLoggedIn = false;
    emit(LogoutStatus());
  }

  void login() {
    isLoggedIn = true;
    emit(LoginStatus());
  }

  bool getProfileData = false;

  void showProfile() async {
    getProfileData = true;
    emit(ShowProfileLoadingState());
    final response = await profileRemoteDatasource.getProfileData();
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;

        getProfileData = false;
        emit(ShowProfileErrorState(
            error: baseErrorModel?.errors?[0] ?? baseErrorModel!.message));
      },
      (r) async {
        profileModel = r;
        print(profileModel);
        getProfileData = false;
        emit(ShowProfileSuccessState());
      },
    );
  }

  void getNotification() async {
    emit(GetNotificationsLoadingState());
    final response = await profileRemoteDatasource.getNotification();
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;

        emit(
          GetNotificationsErrorState(
            error: baseErrorModel?.errors?[0] ?? baseErrorModel!.message,
          ),
        );
      },
      (r) async {
        notifications = r;
        emit(GetNotificationsSuccessState());
      },
    );
  }

  List<NotificationModel> notifications = [];

  bool getUserFollowingLoading = false;

  Map<String, dynamic> userFollowing = {};
  List<UserDataModel> userDataList = [];

  void getUserFollowing() async {
    userDataList = [];
    getUserFollowingLoading = true;
    emit(GetUserFollowingLoadingState());
    final response = await profileRemoteDatasource.getUserFollowing(
      id: userId!,
    );
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        getUserFollowingLoading = false;
        emit(GetUserFollowingErrorState(
            error: baseErrorModel?.errors?[0] ?? baseErrorModel!.message));
      },
      (r) async {
        if (r.getUserFollowingPaginatedModel!.userModel != null) {
          userDataList.addAll(r.getUserFollowingPaginatedModel!.userModel!);
        }
        getUserFollowingLoading = false;
        emit(GetUserFollowingSuccessState());
      },
    );
  }

  bool getVendorFollowingLoading = false;
  List<UserDataModel> vendorFollowingList = [];

  void getVendorFollowing() async {
    vendorFollowingList = [];
    getVendorFollowingLoading = true;
    emit(GetVendorFollowingLoadingState());
    final response = await profileRemoteDatasource.getVendorFollowing(
      id: userId!,
    );
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        getVendorFollowingLoading = false;
        emit(GetVendorFollowingErrorState(
            error: baseErrorModel?.errors?[0] ?? baseErrorModel!.message));
      },
      (r) async {
        if (r.getUserFollowingPaginatedModel!.userModel != null) {
          vendorFollowingList
              .addAll(r.getUserFollowingPaginatedModel!.userModel!);
        }

        getVendorFollowingLoading = false;
        emit(GetVendorFollowingSuccessState());
      },
    );
  }

  bool getVendorProfileData = false;

  Future showVendorProfile({required int id}) async {
    getVendorProfileData = true;
    vendorProfileModel = null;
    emit(ShowVendorProfileLoadingState());
    print(id);
    final response = await profileRemoteDatasource.showVendorDetails(id: id);
    print(response);
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;

        getVendorProfileData = false;
        emit(ShowVendorProfileErrorState(
            error: baseErrorModel?.errors?[0] ?? baseErrorModel!.message));
      },
      (r) async {
        vendorProfileModel = r.vendorProfileModel;
        print(vendorProfileModel);
        getVendorProfileData = false;
        emit(ShowVendorProfileSuccessState());
      },
    );
  }

  void updateProfile({
    required UpdateProfileParameters updateProfileParameters,
  }) async {
    emit(UpdateProfileLoadingState());
    final response = await profileRemoteDatasource.changeProfileData(
      updateProfileParameters: updateProfileParameters,
    );
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(
          UpdateProfileErrorState(
            error: baseErrorModel?.errors?[0] ?? "",
          ),
        );
      },
      (r) async {
        baseResponseModel = r;
        profileImage = null;
        showProfile();
        emit(UpdateProfileSuccessState());
      },
    );
  }

  void updatePassword({
    required ChangePasswordParameters changePasswordParameters,
  }) async {
    emit(UpdateProfileLoadingState());
    final response = await profileRemoteDatasource.changePassword(
      changePasswordParameters: changePasswordParameters,
    );
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(
          UpdateProfileErrorState(
            error: baseErrorModel?.errors?[0] ?? "",
          ),
        );
      },
      (r) async {
        baseResponseModel = r;
        emit(UpdateProfileSuccessState());
      },
    );
  }

  void handleLogout() {
    emit(ProfileInitial());
  }

  @override
  Future<void> close() {
    handleLogout();
    return super.close();
  }
}
