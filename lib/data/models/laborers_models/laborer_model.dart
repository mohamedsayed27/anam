import 'package:equatable/equatable.dart';

import '../services/services_model.dart';
import '../status_moddel.dart';
import '../vendor_info_model.dart';

class LaborerModel extends Equatable {
  final int? id;
  final String? name;
  final String? nationality;
  final String? profession;
  final String? address;
  final String? phone;
  final String? email;
  final String? image;
  final String? coordinates;
  final String? mapLocation;
  final bool? isApproved;
  final VendorInfoModel? vendor;
  final ServiceModel? service;
  final StatusModel? status;
  final String? createdAt;
  final String? updatedAt;

  const LaborerModel({
    this.id,
    this.name,
    this.nationality,
    this.profession,
    this.address,
    this.phone,
    this.email,
    this.image,
    this.coordinates,
    this.mapLocation,
    this.isApproved,
    this.vendor,
    this.service,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    nationality,
    profession,
    address,
    phone,
    email,
    image,
    coordinates,
    mapLocation,
    isApproved,
    vendor,
    service,
    status,
    createdAt,
    updatedAt,
  ];

  factory LaborerModel.fromJson(Map<String, dynamic> json) {
    return LaborerModel(
      id: json['id'],
      name: json['name'],
      nationality: json['nationality'],
      profession: json['profession'],
      address: json['address'],
      phone: json['phone'],
      email: json['email'],
      image: json['image'],
      coordinates: json['coordinates'],
      mapLocation: json['map_location'],
      isApproved: json['is_approved'],
      vendor: json['vendor'] != null ? VendorInfoModel.fromJson(json['vendor']) : null,
      service: json['service'] != null ? ServiceModel.fromJson(json['service']) : null,
      status: json['status'] != null ? StatusModel.fromJson(json['status']) : null,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
