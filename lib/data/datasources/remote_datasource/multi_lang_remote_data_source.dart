import 'package:anam/core/network/dio_helper.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/constants/constants.dart';
import '../../../core/error/error_exception.dart';
import '../../../core/network/api_end_points.dart';
import '../../../core/network/error_message_model.dart';
import '../../models/laborers_models/laborers_multi_lang.dart';

class MultiLangRemoteDataSource{
  final DioHelper dioHelper;

  MultiLangRemoteDataSource({required this.dioHelper});
  Future<Either<ErrorException, LaborerMultiLangModel>> getMultiLang({required int id,}) async{
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
}
