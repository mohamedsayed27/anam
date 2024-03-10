import 'package:anam/core/network/dio_helper.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/constants/constants.dart';
import '../../../core/error/error_exception.dart';
import '../../../core/network/api_end_points.dart';
import '../../../core/network/error_message_model.dart';
import '../../models/laborers_models/laborers_multi_lang.dart';
import '../../models/multi_lang_models/product_multi_lang_model.dart';
import '../../models/multi_lang_models/store_multi_lang_model.dart';
import '../../models/multi_lang_models/veterian_multi_lang_model.dart';

class MultiLangRemoteDataSource{
  final DioHelper dioHelper;

  MultiLangRemoteDataSource({required this.dioHelper});
  Future<Either<ErrorException, LaborerMultiLangModel>> getLaborerMultiLang({required int id,}) async{
    try {
      final response = await dioHelper.getData(
        url: "${EndPoints.laborers}/$id${EndPoints.multiLang}",
        token: token,
      );
      return Right(
        LaborerMultiLangModel.fromJson(response.data["result"]),
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
  Future<Either<ErrorException, ProductMultiLangModel>> geProductMultiLang({required int id,}) async{
    try {
      final response = await dioHelper.getData(
        url: "${EndPoints.products}/$id${EndPoints.multiLang}",
        token: token,
      );
      return Right(
        ProductMultiLangModel.fromJson(response.data["result"]),
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
  Future<Either<ErrorException, StoreMultiLangModel>> geStoreMultiLang({required int id,}) async{
    try {
      final response = await dioHelper.getData(
        url: "${EndPoints.stores}/$id${EndPoints.multiLang}",
        token: token,
      );
      return Right(
        StoreMultiLangModel.fromJson(response.data["result"]),
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
  Future<Either<ErrorException, VeterinarianMultiLangModel>> geVeterinarianMultiLang({required int id,}) async{
    try {
      final response = await dioHelper.getData(
        url: "${EndPoints.veterinarians}/$id${EndPoints.multiLang}",
        token: token,
      );
      return Right(
        VeterinarianMultiLangModel.fromJson(response.data["result"]),
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
