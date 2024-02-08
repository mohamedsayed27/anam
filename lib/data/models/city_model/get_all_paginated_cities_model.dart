import 'package:anam/data/models/base_model.dart';
import 'package:anam/data/models/city_model/city_model.dart';
import 'package:anam/data/models/pagination_model.dart';

class GetAllPaginatedCitiesModel extends BaseResponseModel {
  final CitiesPaginatedModel? citiesPaginatedModel;

  const GetAllPaginatedCitiesModel({
    required super.success,
    required super.code,
    required super.message,
    this.citiesPaginatedModel,
  });

  factory GetAllPaginatedCitiesModel.fromJson(Map<String, dynamic> json) {
    return GetAllPaginatedCitiesModel(
      success: json['success'],
      code: json['code'],
      message: json['message'],
      citiesPaginatedModel: json['result'] != null
          ? CitiesPaginatedModel.fromJson(json['result'])
          : null,
    );
  }
}

class CitiesPaginatedModel extends PaginationModel {
  final List<CityModel>? laborerModel;

  const CitiesPaginatedModel({
    required super.currentPage,
    required super.lastPage,
    required super.total,
    this.laborerModel,
  });

  factory CitiesPaginatedModel.fromJson(Map<String, dynamic> json) {
    return CitiesPaginatedModel(
      currentPage: json['currentPage'],
      lastPage: json['lastPage'],
      total: json['total'],
      laborerModel: json['data'] != null && json['data'].isNotEmpty
          ? List<CityModel>.from(
          json['data'].map((e) => CityModel.fromJson(e)))
          : null,
    );
  }
}

