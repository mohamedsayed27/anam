import 'package:anam/core/network/dio_helper.dart';
import 'package:anam/data/models/city_model/get_all_paginated_cities_model.dart';
import 'package:anam/data/models/country_model/get_all_countries_datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/constants/constants.dart';
import '../../../core/error/error_exception.dart';
import '../../../core/network/api_end_points.dart';
import '../../../core/network/error_message_model.dart';
import '../../models/city_model/get_all_cities.dart';

class CitiesAndCountriesRemoteDatasource{
  final DioHelper dioHelper;

  CitiesAndCountriesRemoteDatasource({required this.dioHelper});


  Future<Either<ErrorException, GetAllPaginatedCitiesModel>> getAllPaginatedCities() async {
    try {
      final response = await dioHelper.getData(
        url: EndPoints.cities,
        token: token,
      );
      return Right(GetAllPaginatedCitiesModel.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel.fromJson(e.response!.data)
          ),
        );
      } else {
        rethrow;
      }
    }
  }


  Future<Either<ErrorException, GetAllCitiesModel>> getAllCities() async {
    try {
      final response = await dioHelper.getData(
        url: "${EndPoints.cities}?is_paginated=false",
        token: token,
      );
      return Right(GetAllCitiesModel.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel.fromJson(e.response!.data)
          ),
        );
      } else {
        rethrow;
      }
    }
  }


  Future<Either<ErrorException, GetAllCountriesModel>> getAllCountries() async {
    try {
      final response = await dioHelper.getData(
        url: EndPoints.countries,
        token: token,
      );
      return Right(GetAllCountriesModel.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel.fromJson(e.response!.data)
          ),
        );
      } else {
        rethrow;
      }
    }
  }
}