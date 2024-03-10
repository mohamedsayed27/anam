import 'package:anam/core/error/error_exception.dart';
import 'package:anam/core/parameters/vet_parameters.dart';
import 'package:anam/data/datasources/remote_datasource/services_base_remote_data_source.dart';
import 'package:anam/data/models/base_model.dart';
import 'package:anam/data/models/vet_models/vet_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/constants/constants.dart';
import '../../../core/network/api_end_points.dart';
import '../../../core/network/dio_helper.dart';
import '../../../core/network/error_message_model.dart';
import '../../models/vet_models/get_all_vet_model.dart';

class VetServicesRemoteDatasource
    extends ServicesBaseDatasource<GetAllVetModel, VetModel, VetParameters> {
  final DioHelper dioHelper;

  VetServicesRemoteDatasource({required this.dioHelper});

  @override
  Future<Either<ErrorException, BaseResponseModel>> delete(
      {required int id}) async {
    try {
      final response = await dioHelper.deleteData(
        url: "${EndPoints.veterinarians}/$id",
        token: token,
      );
      return Right(
        BaseResponseModel.fromJson(response.data),
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

  @override
  Future<Either<ErrorException, GetAllVetModel>> getAll(
      {required int pageNumber}) async {
    try {
      final response = await dioHelper.getData(
        url: "${EndPoints.veterinarians}?page=$pageNumber",
        token: token,
      );
      return Right(GetAllVetModel.fromJson(response.data));
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

  @override
  Future<Either<ErrorException, GetAllVetModel>> getUserFollowing(
      {required int pageNumber}) async {
    try {
      final response = await dioHelper.getData(
        url:
            "${EndPoints.veterinarians}${EndPoints.following}?page=$pageNumber",
        token: token,
      );
      print(response);
      return Right(GetAllVetModel.fromJson(response.data));
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

  @override
  Future<Either<ErrorException, VetModel>> showSingle({required int id}) async {
    try {
      final response = await dioHelper.getData(
        url: "${EndPoints.veterinarians}/$id",
        token: token,
      );
      return Right(
        VetModel.fromJson(response.data),
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

  @override
  Future<Either<ErrorException, VetModel>> update(
      {required VetParameters parameters}) async {
    try {
      final response = await dioHelper.postData(
        url: "${EndPoints.veterinarians}/${parameters.id}",
        data: FormData.fromMap(
          await parameters.toMap(),
        ),
        token: token,
      );
      return Right(
        VetModel.fromJson(response.data),
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

  @override
  Future<Either<ErrorException, VetModel>> upload(
      {required VetParameters parameters}) async {
    try {
      final response = await dioHelper.postData(
        url: EndPoints.veterinarians,
        data: FormData.fromMap(
          await parameters.toMap(),
        ),
        token: token,
      );
      return Right(
        VetModel.fromJson(response.data),
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
