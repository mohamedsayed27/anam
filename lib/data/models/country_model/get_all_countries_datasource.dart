import 'package:anam/data/models/base_model.dart';
import 'package:anam/data/models/city_model/city_model.dart';
import 'package:anam/data/models/country_model/country_model.dart';
import 'package:anam/data/models/pagination_model.dart';

class GetAllCountriesModel extends BaseResponseModel {
  final List<CountryModel>? countriesList;

  const GetAllCountriesModel({
    required super.success,
    required super.code,
    required super.message,
    this.countriesList,
  });

  factory GetAllCountriesModel.fromJson(Map<String, dynamic> json) {
    return GetAllCountriesModel(
      success: json['success'],
      code: json['code'],
      message: json['message'],
      countriesList: json['result'] != null && json['result'].isNotEmpty
          ? List<CountryModel>.from(
          json['result'].map((e) => CountryModel.fromJson(e)))
          : null,
    );
  }
}

