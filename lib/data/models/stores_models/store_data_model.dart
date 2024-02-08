import 'package:equatable/equatable.dart';

import '../city_model/city_model.dart';
import '../country_model/country_model.dart';
import '../services/services_model.dart';
import '../status_moddel.dart';
import '../vendor_info_model.dart';

class StoreDataModel extends Equatable {
  final int? id;
  final String? name;
  final String? phone;
  final String? email;
  final String? image;
  final String? truckType;
  final String? coordinates;
  final String? mapLocation;
  final bool? isApproved;
  final CityModel? city;
  final CountryModel? country;
  final VendorInfoModel? vendor;
  final ServiceModel? service;
  final StatusModel? status;
  final List<TruckImageModel>? truckImages;
  final String? createdAt;
  final String? updatedAt;

  const StoreDataModel({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.image,
    this.truckType,
    this.coordinates,
    this.mapLocation,
    this.isApproved,
    this.city,
    this.country,
    this.vendor,
    this.service,
    this.status,
    this.truckImages,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    phone,
    email,
    image,
    truckType,
    coordinates,
    mapLocation,
    isApproved,
    city,
    country,
    vendor,
    service,
    status,
    truckImages,
    createdAt,
    updatedAt,
  ];

  factory StoreDataModel.fromJson(Map<String, dynamic> json) {
    return StoreDataModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      image: json['image'],
      truckType: json['truck_type'],
      coordinates: json['coordinates'],
      mapLocation: json['map_location'],
      isApproved: json['is_approved'],
      city: json['city'] != null ? CityModel.fromJson(json['city']) : null,
      country: json['country'] != null ? CountryModel.fromJson(json['country']) : null,
      vendor: json['vendor'] != null ? VendorInfoModel.fromJson(json['vendor']) : null,
      service: json['service'] != null ? ServiceModel.fromJson(json['service']) : null,
      status: json['status'] != null ? StatusModel.fromJson(json['status']) : null,
      truckImages: json['truck_images'] != null
          ? List<TruckImageModel>.from(json['truck_images'].map((image) => TruckImageModel.fromJson(image)))
          : null,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class TruckImageModel extends Equatable {
  final int? id;
  final String? image;
  final String? createdAt;
  final String? updatedAt;

  const TruckImageModel({
    this.id,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [id, image, createdAt, updatedAt];

  factory TruckImageModel.fromJson(Map<String, dynamic> json) {
    return TruckImageModel(
      id: json['id'],
      image: json['image'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
