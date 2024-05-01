import 'package:anam/data/models/base_model.dart';
import 'package:anam/data/models/base_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/constants/constants.dart';
import '../../../core/error/error_exception.dart';
import '../../../core/network/api_end_points.dart';
import '../../../core/network/dio_helper.dart';
import '../../../core/network/error_message_model.dart';
import '../../models/packages_model/packages_model.dart';

class PackagesRemoteDataSource {
  final DioHelper dioHelper;

  PackagesRemoteDataSource({required this.dioHelper});

  Future<Either<ErrorException, GetAllPackagesModel>> getAllPackages() async {
    try {
      final response = await dioHelper.getData(
        url: "${EndPoints.packages}/?is_paginated=false",
        token: token,
      );
      print(response);
      return Right(
        GetAllPackagesModel.fromJson(response.data),
      );
    } catch (e) {
      if (e is DioException) {
        print(e);
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

  Future<Either<ErrorException, BaseResponseModel>> subscribeAPackage({
    required String? tranRef,
    required String? packageId,
  }) async {
    try {
      final response = await dioHelper.postData(
        url: EndPoints.subscribePackage,
        data: FormData.fromMap({
          "tran_ref": tranRef,
          "package_id": packageId,
        }),
      );
      print("Test Subscribe Package");
      print(response);
      return Right(
        BaseResponseModel.fromJson(response.data),
      );
    } catch (e) {
      if (e is DioException) {
        print("Test Subscribe error package");
        print(e);
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
