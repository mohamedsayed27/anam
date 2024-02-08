import '../base_model.dart';
import 'city_model.dart';

class GetAllCitiesModel extends BaseResponseModel {
  final List<CityModel>? citiesList;

  const GetAllCitiesModel({
    required super.success,
    required super.code,
    required super.message,
    this.citiesList,
  });

  factory GetAllCitiesModel.fromJson(Map<String, dynamic> json) {
    return GetAllCitiesModel(
      success: json['success'],
      code: json['code'],
      message: json['message'],
      citiesList: json['result'] != null&&json['result'].isNotEmpty
          ? List<CityModel>.from(json['result'].map((e)=>CityModel.fromJson(e)))
          : null,
    );
  }
}
