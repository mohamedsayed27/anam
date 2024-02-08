import 'package:anam/data/models/vendor_info_model.dart';
import 'package:equatable/equatable.dart';

import '../city_model/city_model.dart';
import '../country_model/country_model.dart';
import '../services/services_model.dart';
import '../../models/status_moddel.dart';

class VetModel extends Equatable {
  final int? id;
  final String? name;
  final String? address;
  final String? qualification;
  final String? phone;
  final String? email;
  final String? image;
  final String? coordinates;
  final String? mapLocation;
  final bool? isApproved;
  final CityModel? city;
  final CountryModel? country;
  final VendorInfoModel? vendor;
  final ServiceModel? service;
  final StatusModel? status;
  final String? createdAt;
  final String? updatedAt;

  const VetModel({
    this.id,
    this.name,
    this.address,
    this.qualification,
    this.phone,
    this.email,
    this.image,
    this.coordinates,
    this.mapLocation,
    this.isApproved,
    this.city,
    this.country,
    this.vendor,
    this.service,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory VetModel.fromJson(Map<String, dynamic> json) {
    return VetModel(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      qualification: json['qualification'],
      phone: json['phone'],
      email: json['email'],
      image: json['image'],
      coordinates: json['coordinates'],
      mapLocation: json['map_location'],
      isApproved: json['is_approved'],
      city: json['city'] != null ? CityModel.fromJson(json['city']) : null,
      country: json['country'] != null ? CountryModel.fromJson(json['country']) : null,
      vendor: json['vendor'] != null ? VendorInfoModel.fromJson(json['vendor']) : null,
      service: json['service'] != null ? ServiceModel.fromJson(json['service']) : null,
      status: json['status'] != null ? StatusModel.fromJson(json['status']) : null,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

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
    city,
    country,
    vendor,
    service,
    status,
    createdAt,
    updatedAt,
  ];
}

