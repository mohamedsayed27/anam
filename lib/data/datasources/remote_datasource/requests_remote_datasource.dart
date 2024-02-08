import 'package:anam/core/parameters/request_parameters.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/constants/constants.dart';
import '../../../core/error/error_exception.dart';
import '../../../core/network/api_end_points.dart';
import '../../../core/network/dio_helper.dart';
import '../../../core/network/error_message_model.dart';
import '../../models/requests/get_all_requests_model.dart';
import '../../models/requests/request_model.dart';

class RequestsRemoteDatasource {
  final DioHelper dioHelper;

  RequestsRemoteDatasource({required this.dioHelper});

  Future<Either<ErrorException, GetAllRequestsModel>> getAllRequests(
      {required int pageNumber}) async {
    try {
      final response = await dioHelper.getData(
        url: "${EndPoints.requests}?page=$pageNumber",
        token: token,
      );
      return Right(GetAllRequestsModel.fromJson(response.data));
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

  Future<Either<ErrorException, GetAllRequestsModel>> getPreviousRequests(
      {required int pageNumber}) async {
    try {
      final response = await dioHelper.getData(
        url: "${EndPoints.previousRequests}?page=$pageNumber",
        token: token,
      );
      return Right(GetAllRequestsModel.fromJson(response.data));
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

  Future<Either<ErrorException, RequestModel>> sendRequest(
      {required RequestParameters requestParameters}) async {
    try {
      final response = await dioHelper.postData(
        url: EndPoints.requests,
        data: FormData.fromMap(requestParameters.toMap()),
        token: token,
      );
      return Right(RequestModel.fromJson(response.data));
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

  Future<Either<ErrorException, RequestModel>> showRequest({
    required int id,
  }) async {
    try {
      final response = await dioHelper.getData(
        url: "${EndPoints.requests}/$id",
        token: token,
      );
      return Right(RequestModel.fromJson(response.data));
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
