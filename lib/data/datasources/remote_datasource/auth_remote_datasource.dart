import 'package:anam/core/network/dio_helper.dart';
import 'package:anam/core/parameters/register_parameters.dart';
import 'package:anam/data/models/auth_models/login_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/error/error_exception.dart';
import '../../../core/network/api_end_points.dart';
import '../../../core/network/error_message_model.dart';

class AuthRemoteDataSource {
  final DioHelper dioHelper;

  AuthRemoteDataSource({required this.dioHelper});

  Future<Either<ErrorException, LoginAndRegisterModel>> register({
    required RegisterParameters parameters,
  }) async {
    try {
      final response = await dioHelper.postData(
        url: EndPoints.register,
        data: FormData.fromMap(parameters.toMap()),
      );
      return Right(LoginAndRegisterModel.fromJson(response.data));
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

  Future<Either<ErrorException, LoginAndRegisterModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dioHelper.postData(
        url: EndPoints.login,
        data: FormData.fromMap({
          "email": email,
          "password": password,
        }),
      );
      return Right(
        LoginAndRegisterModel.fromJson(response.data),
      );
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
