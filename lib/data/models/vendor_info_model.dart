import 'package:equatable/equatable.dart';

class VendorInfoModel extends Equatable {
  final int? id;
  final String? name;
  final String? image;
  final String? email;
  final String? phone;
  final String? location;
  final String? address;
  final String? socialId;
  final String? socialType;
  final String? vendorPage;
  final String? type;
  final String? createdAt;
  final String? updatedAt;
  final bool? isFollowed;

  const VendorInfoModel({
    this.id,
    this.name,
    this.image,
    this.email,
    this.isFollowed,
    this.phone,
    this.location,
    this.address,
    this.socialId,
    this.socialType,
    this.vendorPage,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    image,
    email,
    phone,
    location,
    address,
    socialId,
    socialType,
    vendorPage,
    type,
    createdAt,
    updatedAt,
  ];

  factory VendorInfoModel.fromJson(Map<String, dynamic> json) {
    return VendorInfoModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      email: json['email'],
      phone: json['phone'],
      location: json['location'],
      isFollowed: json['is_followed'],
      address: json['address'],
      socialId: json['social_id'],
      socialType: json['social_type'],
      vendorPage: json['vendor_page'],
      type: json['type'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
