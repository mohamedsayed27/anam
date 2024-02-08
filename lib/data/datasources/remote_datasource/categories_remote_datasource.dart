import 'package:anam/core/network/dio_helper.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/constants/constants.dart';
import '../../../core/error/error_exception.dart';
import '../../../core/network/api_end_points.dart';
import '../../../core/network/error_message_model.dart';
import '../../models/categories/get_all_categories.dart';
import '../../models/categories/show_category_model.dart';

class CategoriesRemoteDatasource {
  final DioHelper dioHelper;

  CategoriesRemoteDatasource({
    required this.dioHelper,
  });

  Future<Either<ErrorException, GetAllCategoriesModel>> getAllCategories(
      {required int pageNumber,}) async {
    try {
      final response = await dioHelper.getData(
        url: "${EndPoints.categories}?page=$pageNumber",
        token: token,
      );
      return Right(GetAllCategoriesModel.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        return Left(
          ErrorException(
              baseErrorModel: BaseErrorModel.fromJson(e.response!.data)),
        );
      } else {
        rethrow;
      }
    }
  }

  Future<Either<ErrorException, ShowCategoryModel>> showCategory({
    required int id,
  }) async {
    try {
      final response = await dioHelper.getData(
        url: "${EndPoints.categories}/$id",
        token: token,
      );
      return Right(
        ShowCategoryModel.fromJson(
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
