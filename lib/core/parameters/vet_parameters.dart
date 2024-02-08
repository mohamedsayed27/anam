import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;


class VetParameters extends Equatable {
  final String? nameAr;
  final String? nameEn;
  final String? phone;
  final File? image;
  final String? coordinates;
  final String? id;
  final String? mapLocation;
  final String? email;
  final String? addressAr;
  final String? addressEn;
  final String? qualificationAr;
  final String? qualificationEn;
  final String? cityId;
  final String? countryId;

  const VetParameters({
    this.nameAr,
    this.nameEn,
    this.id,
    this.phone,
    this.image,
    this.coordinates,
    this.mapLocation,
    this.email,
    this.addressAr,
    this.addressEn,
    this.qualificationAr,
    this.qualificationEn,
    this.cityId,
    this.countryId,
  });

  @override
  List<Object?> get props => [
    nameAr,
    nameEn,
    phone,
    image,
    coordinates,
    mapLocation,
    email,
    addressAr,
    addressEn,
    qualificationAr,
    qualificationEn,
    cityId,
    countryId,
  ];

  Future<Map<String, dynamic>> toMap() async{
    return {
      'name_ar': nameAr,
      'name_en': nameEn,
      'phone': phone,
      'image': await MultipartFile.fromFile(
        image!.path,
        filename: path.basename(image!.path),
      ), // Assuming you want the file path here
      'coordinates': coordinates,
      'map_location': mapLocation,
      'email': email,
      'address_ar': addressAr,
      'address_en': addressEn,
      'qualification_ar': qualificationAr,
      'qualification_en': qualificationEn,
      'city_id': cityId,
      'country_id': countryId,
    };
  }
}