import 'dart:io';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:path/path.dart' as path;

class LaborerParameters extends Equatable {
  final String? nameAr;
  final String? nameEn;
  final String? phone;
  final String? method;
  final File? image;
  final String? id;
  final String? coordinates;
  final String? mapLocation;
  final String? nationalityAr;
  final String? nationalityEn;
  final String? email;
  final String? professionAr;
  final String? professionEn;
  final String? addressAr;
  final String? addressEn;

  const LaborerParameters({
    this.nameAr,
    this.id,
    this.nameEn,
    this.phone,
    this.method,
    this.image,
    this.coordinates,
    this.mapLocation,
    this.nationalityAr,
    this.nationalityEn,
    this.email,
    this.professionAr,
    this.professionEn,
    this.addressAr,
    this.addressEn,
  });

  @override
  List<Object?> get props => [
        nameAr,
        nameEn,
        phone,
        image,
        coordinates,
        mapLocation,
        nationalityAr,
    method,
        nationalityEn,
        email,
        professionAr,
        professionEn,
        addressAr,
        addressEn,
      ];

  Future<Map<String, dynamic>> toMap() async {
    return {
      'name_ar': nameAr,
      'name_en': nameEn,
      'phone': phone,
      if(method!=null)'_method': method,
      if( image != null)'image': image != null
          ? await MultipartFile.fromFile(
              image!.path,
              filename: path.basename(image!.path),
            )
          : null, // Assuming you want the file path here
      'coordinates': coordinates,
      'map_location': mapLocation,
      'nationality_ar': nationalityAr,
      'nationality_en': nationalityEn,
      'email': email,
      'profession_ar': professionAr,
      'profession_en': professionEn,
      'address_ar': addressAr,
      'address_en': addressEn,
    };
  }
}
