import 'dart:convert';
import 'dart:developer';

import 'package:anam/core/cache_helper/cache_keys.dart';
import 'package:anam/core/cache_helper/shared_pref_methods.dart';
import 'package:anam/core/parameters/review_product_parameters.dart';
import 'package:anam/data/models/base_model.dart';
import 'package:anam/data/models/products_model/product_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/constants/constants.dart';
import '../../../core/error/error_exception.dart';
import '../../../core/network/api_end_points.dart';
import '../../../core/network/dio_helper.dart';
import '../../../core/network/error_message_model.dart';
import '../../../core/parameters/upload_product_parameters.dart';
import '../../models/products_model/get_all_product_model.dart';
import '../../models/products_model/upload_or_update_product_model.dart';
import '../../models/reviews_model.dart';

class ProductsRemoteDatasource {
  final DioHelper dioHelper;

  ProductsRemoteDatasource({
    required this.dioHelper,
  });

  Future<Either<ErrorException, GetAllProductModel>> getAllProducts({
    required int pageNumber,
  }) async {
    try {
      final response = await dioHelper.getData(
        url: "${EndPoints.products}?page=$pageNumber",
      );
      for(var element in response.data["result"]["data"]){
      }
      // log('All Product log response ${jsonEncode(response.data)}');
      return Right(GetAllProductModel.fromJson(response.data));
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

  Future<Either<ErrorException, GetAllProductModel>> getAllSearchedProducts({
    required int pageNumber,
    required String value,
  }) async {
    try {
      final response = await dioHelper.getData(
        url: "${EndPoints.products}?search=$value&page=$pageNumber",
        // query: {
        //   "search": value,
        // },
      );
      return Right(GetAllProductModel.fromJson(response.data));
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

  Future<Either<ErrorException, BaseResponseModel>> deleteProductImages({
    required int id,
  }) async {
    try {
      final response = await dioHelper.deleteData(
        url: EndPoints.deleteProductImages,
        // contentType: "application/x-www-form-urlencoded",
        data: {
          "ids": [id], // Pass id as a list
        },
        // query: {
        //   "search": value,
        // },
      );
      return Right(BaseResponseModel.fromJson(response.data));
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

  Future<Either<ErrorException, GetAllProductModel>> getFavoriteProducts(
      {required int pageNumber,}) async {
    try {
      final response = await dioHelper.getData(
        url: "${EndPoints.wishList}?page=$pageNumber",
        token: token,
      );
      return Right(GetAllProductModel.fromJson(response.data));
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

  Future<Either<ErrorException, BaseResponseModel>> addToFavorite(
      {required int id}) async {
    try {
      final response = await dioHelper.postData(
        url: "${EndPoints.changeWishProduct}/$id",
        token: token,
      );
      return Right(BaseResponseModel.fromJson(response.data));
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

  Future<Either<ErrorException, BaseResponseModel>> changeProductStatus({
    required int id,
    required String status,
  }) async {
    try {
      final response = await dioHelper.postData(
        url: "${EndPoints.changeProductStatus}/$id",
        data: FormData.fromMap({
          "productStatus": status,
        }),
        token: token,
      );
      return Right(BaseResponseModel.fromJson(response.data));
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

  Future<Either<ErrorException, GetAllProductModel>> getUserFollowingProducts(
      {required int pageNumber}) async {
    try {
      final response = await dioHelper.getData(
        url: "${EndPoints.products}${EndPoints.following}?page=$pageNumber",
        token: token,
      );
      for(var element in response.data["result"]["data"]){
      }
      // log('All User Following log response ${jsonEncode(response.data)}');
      return Right(GetAllProductModel.fromJson(response.data));
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

  Future<Either<ErrorException, ProductDataModel>> showProduct({
    required int id,
  }) async {
    try {
      final response = await dioHelper.getData(
        url: "${EndPoints.products}/$id",
        token: token,
      );
      return Right(
        ProductDataModel.fromJson(
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

  Future<Either<ErrorException, GetAllProductReviews>> getAllProductReviews({
    required String id,
  }) async {
    try {
      final response = await dioHelper.getData(
        url: EndPoints.reviewProduct(id: id),
        token: token,
      );
      return Right(
        GetAllProductReviews.fromJson(
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

  Future<Either<ErrorException, BaseResponseModel>> addProductReview({
    required String id,
    required ReviewProductParameters reviewProductParameters,
  }) async {
    try {
      final response = await dioHelper.postData(
        url: EndPoints.postReviewProduct(id: id),
        token: token,
        data: FormData.fromMap(reviewProductParameters.toMap()),
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

  Future<Either<ErrorException, BaseResponseModel>> deleteProduct({
    required int id,
  }) async {
    try {
      final response = await dioHelper.deleteData(
        url: "${EndPoints.products}/$id",
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

  Future<Either<ErrorException, UploadOrUpdateProductModel>> uploadProduct({
    required ProductParameters productParameters,
  }) async {
    print(await productParameters.toMap());
    try {
      final response = await dioHelper.postData(
        url: EndPoints.products,
        data: FormData.fromMap(
          await productParameters.toMap(),
        ),
        token: token,
      );
      print(response);

      return Right(
        UploadOrUpdateProductModel.fromJson(
          response.data,
        ),
      );
    } catch (e) {
      if (e is DioException) {
        print(e.response);
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

  Future<Either<ErrorException, UploadOrUpdateProductModel>> updateProduct({
    required ProductParameters productParameters,
  }) async {
    try {
      final response = await dioHelper.postData(
        url: "${EndPoints.products}/${productParameters.productId}",
        data: FormData.fromMap(
          await productParameters.toMap(),
        ),
        token: token,
      );
      return Right(
        UploadOrUpdateProductModel.fromJson(
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
