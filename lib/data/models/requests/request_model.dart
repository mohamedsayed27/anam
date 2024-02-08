import 'package:equatable/equatable.dart';

class RequestModel extends Equatable {
  final String? title;
  final String? description;
  final String? price;
  final String? notes;
  final String? countryId;
  final String? coordinates;
  final String? mapLocation;
  final int? userId;
  final int? statusId;
  final UserInformation? userInformation;
  final String? updatedAt;
  final String? createdAt;
  final int? id;

  const RequestModel({
    required this.title,
    required this.description,
    required this.price,
    required this.notes,
    required this.countryId,
    required this.coordinates,
    required this.userInformation,
    required this.mapLocation,
    required this.userId,
    required this.statusId,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  @override
  List<Object?> get props => [
        title,
        description,
        price,
        notes,
        countryId,
        coordinates,
        mapLocation,
        userId,
        statusId,
        updatedAt,
        createdAt,
        id,
      ];

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      title: json['title'],
      description: json['description'],
      price: json['price'],
      notes: json['notes'],
      userInformation:
          json['user'] != null ? UserInformation.fromJson(json['user']) : null,
      countryId: json['country_id'],
      coordinates: json['coordinates'],
      mapLocation: json['map_location'],
      userId: json['user_id'],
      statusId: json['status_id'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
      id: json['id'],
    );
  }
}

class UserInformation extends Equatable {
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

  const UserInformation({
    this.id,
    this.name,
    this.image,
    this.email,
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

  factory UserInformation.fromJson(Map<String, dynamic> json) {
    return UserInformation(
      id: json['id'] as int?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      location: json['location'] as String?,
      address: json['address'] as String?,
      socialId: json['social_id'] as String?,
      socialType: json['social_type'] as String?,
      vendorPage: json['vendor_page'] as String?,
      type: json['type'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

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
}
