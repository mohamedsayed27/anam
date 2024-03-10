import 'dart:io';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:path/path.dart' as path;

class StoreParameters extends Equatable {
  final String? countryId;
  final String? cityId;
  final String? nameAr;
  final String? nameEn;
  final String? phone;
  final File? image;
  final String? coordinates;
  final String? mapLocation;
  final String? truckTypeAr;
  final String? truckTypeEn;
  final List<File>? images;
  final String? email;
  final String? id;
  final String? method;
  const StoreParameters({
    this.countryId,
    this.cityId,
    this.nameAr,
    this.method,
    this.nameEn,
    this.phone,
    this.image,
    this.coordinates,
    this.mapLocation,
    this.truckTypeAr,
    this.id,
    this.truckTypeEn,
    this.images,
    this.email,
  });

  @override
  List<Object?> get props => [
    countryId,
    cityId,
    nameAr,
    nameEn,
    phone,
    image,
    coordinates,
    mapLocation,
    truckTypeAr,
    method,
    truckTypeEn,
    images,
    email,
  ];

  Future<Map<String, dynamic>> toMap() async{
    final formData = FormData();
    if(images!=null) {
      images?.forEach((element) async{
      formData.files.add(MapEntry("images", await MultipartFile.fromFile(
        element.path,
        filename: path.basename(element.path),
      )));
    });
    }
    Map<String, dynamic> data = {
      'country_id': countryId,
      'city_id': cityId,
      'name_ar': nameAr,
      if(method!=null)"_method":method,
      'name_en': nameEn,
      'phone': phone,
      if(image!=null)'image': await MultipartFile.fromFile(
        image!.path,
        filename: path.basename(image!.path),
      ), // Assuming you want the file path here
      'coordinates': coordinates,
      'map_location': mapLocation,
      'truck_type_ar': truckTypeAr,
      'truck_type_en': truckTypeEn,
      'email': email,
    };
    formData.files.map((e) {
      data.addAll({e.key:e.value});
    });
    return data;
  }
}
