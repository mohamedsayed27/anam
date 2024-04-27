import 'package:equatable/equatable.dart';

import 'image_multi_lang_model.dart';

class VeterinarianMultiLangModel extends Equatable {
  final int? id;
  final Map<String, String>? name;
  final Map<String, String>? address;
  final Map<String, String>? qualification;
  final String? phone;
  final String? email;
  final String? image;
  final String? coordinates;
  final String? mapLocation;
  final int? isApproved;
  final int? cityId;
  final int? countryId;
  final int? vendorId;
  final int? serviceId;
  final int? statusId;
  final String? createdAt;
  final String? updatedAt;
  final List<MultiLangImageModel>? images;
  const VeterinarianMultiLangModel( {
    this.id,
    this.images,
    this.name,
    this.address,
    this.qualification,
    this.phone,
    this.email,
    this.image,
    this.coordinates,
    this.mapLocation,
    this.isApproved,
    this.cityId,
    this.countryId,
    this.vendorId,
    this.serviceId,
    this.statusId,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    address,
    qualification,
    phone,
    email,
    image,
    coordinates,
    mapLocation,
    isApproved,
    cityId,
    countryId,
    vendorId,
    serviceId,
    statusId,
    createdAt,
    updatedAt,
  ];

  factory VeterinarianMultiLangModel.fromJson(Map<String, dynamic> json) {
    return VeterinarianMultiLangModel(
      id: json['id'],
      name: json['name'] != null ? Map<String, String>.from(json['name']) : null,
      address: json['address'] != null ? Map<String, String>.from(json['address']) : null,
      qualification: json['qualification'] != null ? Map<String, String>.from(json['qualification']) : null,
      phone: json['phone'],
      email: json['email'],
      image: json['image'],
      coordinates: json['coordinates'],
      mapLocation: json['map_location'],
      images:json['images'] != null&& json['images'].isNotEmpty
          ? List<MultiLangImageModel>.from(
        json['images'].map((e) => MultiLangImageModel.fromJson(e)),
      )
          : null,
      isApproved: json['is_approved'],
      cityId: json['city_id'],
      countryId: json['country_id'],
      vendorId: json['vendor_id'],
      serviceId: json['service_id'],
      statusId: json['status_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'qualification': qualification,
      'phone': phone,
      'email': email,
      'image': image,
      'coordinates': coordinates,
      'map_location': mapLocation,
      'is_approved': isApproved,
      'city_id': cityId,
      'country_id': countryId,
      'vendor_id': vendorId,
      'service_id': serviceId,
      'status_id': statusId,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
