import 'package:anam/core/network/dio_helper.dart';
import 'package:anam/core/parameters/change_password_parameters.dart';
import 'package:anam/core/parameters/update_profile_parameters.dart';
import 'package:anam/data/models/base_model.dart';
import 'package:anam/data/models/following_model/following_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/constants/constants.dart';
import '../../../core/error/error_exception.dart';
import '../../../core/network/api_end_points.dart';
import '../../../core/network/error_message_model.dart';
import '../../models/user_model/profile_model.dart';
import '../../models/vendor_data_model.dart';

class ProfileRemoteDatasource {
  final DioHelper dioHelper;

  ProfileRemoteDatasource({required this.dioHelper});

  Future<Either<ErrorException, ProfileModel>> getProfileData() async {
    try {
      final response = await dioHelper.getData(
        url: EndPoints.profile,
        token: token,
      );
      return Right(ProfileModel.fromJson(response.data["result"]));
    } catch (e) {
      if (e is DioException) {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel.fromJson(e.response!.data),
          ),
        );
      } else {
        rethrow;
      }
    }
  }

  Future<Either<ErrorException, GetVendorDetailsWidget>> showVendorDetails({required int id}) async {
    try {
      final response = await dioHelper.getData(
        url: "${EndPoints.vendorDetails}/$id",
        token: token,
      );
      return Right(GetVendorDetailsWidget.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel.fromJson(e.response!.data),
          ),
        );
      } else {
        rethrow;
      }
    }
  }

  Future<Either<ErrorException, GetUserFollowingModel>> getUserFollowing({required String id}) async {
    try {
      final response = await dioHelper.getData(
        url: EndPoints.userFollowing(id: id.toString()),
        token: token,
      );
      return Right(GetUserFollowingModel.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel.fromJson(e.response!.data),
          ),
        );
      } else {
        rethrow;
      }
    }
  }

  Future<Either<ErrorException, GetUserFollowingModel>> getVendorFollowing({required String id}) async {
    try {
      final response = await dioHelper.getData(
        url: EndPoints.vendorFollowing(id: id.toString()),
        token: token,
      );
      print(response);
      return Right(GetUserFollowingModel.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel.fromJson(e.response!.data),
          ),
        );
      } else {
        rethrow;
      }
    }
  }

  Future<Either<ErrorException, BaseResponseModel>> changePassword({required ChangePasswordParameters changePasswordParameters}) async {
    try {
      final response = await dioHelper.putData(
        url: EndPoints.password,
        data: FormData.fromMap(changePasswordParameters.toMap(),),
        token: token,
      );
      return Right(BaseResponseModel.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel.fromJson(e.response!.data),
          ),
        );
      } else {
        rethrow;
      }
    }
  }

  Future<Either<ErrorException, BaseResponseModel>> changeProfileData({required UpdateProfileParameters updateProfileParameters}) async {
    try {
      final response = await dioHelper.postData(
        url: EndPoints.profile,
        data: FormData.fromMap(await updateProfileParameters.toMap(),),
        token: token,
      );
      return Right(BaseResponseModel.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel.fromJson(e.response!.data),
          ),
        );
      } else {
        rethrow;
      }
    }
  }
}
