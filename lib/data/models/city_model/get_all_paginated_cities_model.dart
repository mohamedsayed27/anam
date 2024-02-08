import 'package:anam/data/models/base_model.dart';
import 'package:anam/data/models/city_model/city_model.dart';
import 'package:anam/data/models/pagination_model.dart';

class GetAllCitiesModel extends BaseResponseModel {
  final CitiesPaginatedModel? citiesPaginatedModel;

  const GetAllCitiesModel({
    required super.success,
    required super.code,
    required super.message,
    this.citiesPaginatedModel,
  });

  factory GetAllCitiesModel.fromJson(Map<String, dynamic> json) {
    return GetAllCitiesModel(
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

