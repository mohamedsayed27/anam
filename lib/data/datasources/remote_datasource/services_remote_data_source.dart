import 'package:anam/core/network/dio_helper.dart';
import 'package:anam/data/models/laborers_models/get_all_laborers_model.dart';
import 'package:anam/data/models/services/get_all_services.dart';
import 'package:anam/data/models/services/services_model.dart';
import 'package:anam/data/models/services/services_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/constants/constants.dart';
import '../../../core/error/error_exception.dart';
import '../../../core/network/api_end_points.dart';
import '../../../core/network/error_message_model.dart';

class ServicesRemoteDataSource{
  final DioHelper dioHelper;

  ServicesRemoteDataSource({required this.dioHelper});

  Future<Either<ErrorException, GetAllServicesModel>> getAllServices(
      {required int pageNumber}) async {
    try {
      final response = await dioHelper.getData(
        url: "${EndPoints.services}?page=$pageNumber",
        token: token,
      );
      return Right(GetAllServicesModel.fromJson(response.data));
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

  Future<Either<ErrorException, GetAllLaborersModel>> getAllServicesItems({required int pageNumber}) async {
    try {
      final response = await dioHelper.getData(
        url: "${EndPoints.services}/items?page=$pageNumber",
        token: token,
      );
      return Right(
        GetAllLaborersModel.fromJson(response.data),
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