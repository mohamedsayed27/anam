import 'package:equatable/equatable.dart';

class LaborerMultiLangModel extends Equatable {
  final int? id;
  final Map<String, String>? name;
  final String? phone;
  final String? email;
  final String? image;
  final Map<String, String>? truckType;
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

  const LaborerMultiLangModel({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.image,
    this.truckType,
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

  factory LaborerMultiLangModel.fromJson(Map<String, dynamic> json) {
    return LaborerMultiLangModel(
      id: json['id'],
      name: json['name'] != null ? Map<String, String>.from(json['name']) : null,
      phone: json['phone'],
      email: json['email'],
      image: json['image'],
      truckType: json['truck_type'] != null ? Map<String, String>.from(json['truck_type']) : null,
      coordinates: json['coordinates'],
      mapLocation: json['map_location'],
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
    cityId,
    countryId,
    vendorId,
    serviceId,
    statusId,
    createdAt,
    updatedAt,
  ];
}
