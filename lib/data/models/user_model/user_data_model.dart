import 'package:equatable/equatable.dart';

class UserDataModel extends Equatable {
  final int id;
  final String name;
  final String image;
  final String email;
  final String? phone;
  final String? location;
  final String? address;
  final String? socialId;
  final String? socialType;
  final String type;
  final String createdAt;
  final String updatedAt;

  const UserDataModel({
    required this.id,
    required this.name,
    required this.image,
    required this.email,
    this.phone,
    this.location,
    this.address,
    this.socialId,
    this.socialType,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      email: json['email'],
      phone: json['phone'],
      location: json['location'],
      address: json['address'],
      socialId: json['social_id'],
      socialType: json['social_type'],
      type: json['type'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
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
    type,
    createdAt,
    updatedAt,
  ];
}
