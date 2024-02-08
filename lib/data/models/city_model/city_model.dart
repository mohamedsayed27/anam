
import 'package:equatable/equatable.dart';

import '../country_model/country_model.dart';

class CityModel extends Equatable{
  final int? id;
  final String? name;
  final CountryModel? country;
  final String? createdAt;
  final String? updatedAt;
  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'],
      name: json['name'],
      country: json['country'] != null ? CountryModel.fromJson(json['country']) : null,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
  const CityModel({
    this.id,
    this.name,
    this.country,
    this.createdAt,
    this.updatedAt,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    name,
    country,
    createdAt,
    updatedAt
    ,];
}