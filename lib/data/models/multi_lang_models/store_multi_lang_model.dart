import 'package:equatable/equatable.dart';

class StoreMultiLangModel extends Equatable {
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

  const StoreMultiLangModel({
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

  factory StoreMultiLangModel.fromJson(Map<String, dynamic> json) {
    return StoreMultiLangModel(
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'image': image,
      'truck_type': truckType,
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
