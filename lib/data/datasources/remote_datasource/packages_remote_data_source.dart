import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/constants/constants.dart';
import '../../../core/error/error_exception.dart';
import '../../../core/network/api_end_points.dart';
import '../../../core/network/dio_helper.dart';
import '../../../core/network/error_message_model.dart';
import '../../models/packages_model/packages_model.dart';

class PackagesRemoteDataSource{
  final DioHelper dioHelper;

  PackagesRemoteDataSource({required this.dioHelper});
  Future<Either<ErrorException, GetAllPackagesModel>> getAllPackages() async{
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