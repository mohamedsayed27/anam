import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;

class UpdateProfileParameters {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final File? image;
  final String? method;

  UpdateProfileParameters( {
    this.firstName,
    this.lastName,
    this.image,
    this.method,
    this.email,
    this.phone,
  });

  Future<Map<String, dynamic>> toMap() async{
    Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['_method'] = method;
    data['image'] = await MultipartFile.fromFile(
      image!.path,
      filename: path.basename(image!.path),
    );
    return data;
  }
}
