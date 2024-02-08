import 'package:anam/core/network/dio_helper.dart';
import 'package:anam/core/parameters/store_parameters.dart';
import 'package:anam/data/models/stores_models/get_all_store_model.dart';
import 'package:anam/data/models/stores_models/store_data_model.dart';
import 'package:anam/data/models/stores_models/store_data_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/constants/constants.dart';
import '../../../core/error/error_exception.dart';
import '../../../core/network/api_end_points.dart';
import '../../../core/network/error_message_model.dart';
import '../../models/base_model.dart';
import 'services_base_remote_data_source.dart';

class StoresDataSource extends ServicesBaseUseCase<GetAllStoreModel,
    StoreDataModel, StoreParameters> {
  final DioHelper dioHelper;

  StoresDataSource({required this.dioHelper});

  @override
  Future<Either<ErrorException, GetAllStoreModel>> getAll(
      {required int pageNumber}) async {
    try {
      final response = await dioHelper.getData(
        url: "${EndPoints.stores}?page=$pageNumber",
        token: token,
      );
      return Right(GetAllStoreModel.fromJson(response.data));
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
  Future<Either<ErrorException, GetAllStoreModel>> getUserFollowing(
      {required int pageNumber}) async {
    try {
      final response = await dioHelper.getData(
        url: "${EndPoints.stores}${EndPoints.following}?page=$pageNumber",
        token: token,
      );
      return Right(GetAllStoreModel.fromJson(response.data));
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

  Future<Either<ErrorException, StoreDataModel>> showSingle({
    required int id,
  }) async {
    try {
      final response = await dioHelper.getData(
        url: "${EndPoints.stores}/$id",
        token: token,
      );
      return Right(
        StoreDataModel.fromJson(
          response.data,
        ),
      );
    } catch (e) {
      if (e is DioException) {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel.fromJson(
              e.response!.data,
            ),
          ),
        );
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<Either<ErrorException, BaseResponseModel>> delete({
    required int id,
  }) async {
    try {
      final response = await dioHelper.getData(
        url: "${EndPoints.stores}/$id",
        token: token,
      );
      return Right(
        BaseResponseModel.fromJson(
          response.data,
        ),
      );
    } catch (e) {
      if (e is DioException) {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel.fromJson(
              e.response!.data,
            ),
          ),
        );
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<Either<ErrorException, StoreDataModel>> update({
    required StoreParameters parameters,
  }) async {
    try {
      final response = await dioHelper.putData(
        url: "${EndPoints.stores}/${parameters.id}",
        data: FormData.fromMap(
          await parameters.toMap(),
        ),
        token: token,
      );
      return Right(
        StoreDataModel.fromJson(
          response.data,
        ),
      );
    } catch (e) {
      if (e is DioException) {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel.fromJson(
              e.response!.data,
            ),
          ),
        );
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<Either<ErrorException, StoreDataModel>> upload(
      {required StoreParameters parameters}) async {
    try {
      final response = await dioHelper.postData(
        url: EndPoints.stores,
        data: FormData.fromMap(
          await parameters.toMap(),
        ),
        token: token,
      );
      return Right(
        StoreDataModel.fromJson(
          response.data,
        ),
      );
    } catch (e) {
      if (e is DioException) {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel.fromJson(
              e.response!.data,
            ),
          ),
        );
      } else {
        rethrow;
      }
    }
  }
}
