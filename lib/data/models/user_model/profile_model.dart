import 'package:equatable/equatable.dart';

class ProfileModel extends Equatable {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? image;
  final String? email;
  final String? phone;
  final String? location;
  final String? address;
  final String? createdAt;
  final String? updatedAt;

  const ProfileModel({
    this.id,
    this.firstName,
    this.lastName,
    this.image,
    this.email,
    this.phone,
    this.location,
    this.address,
    this.createdAt,
    this.updatedAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      image: json['image'],
      email: json['email'],
      phone: json['phone'],
      location: json['location'],
      address: json['address'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['image'] = image;
    data['email'] = email;
    data['phone'] = phone;
    data['location'] = location;
    data['address'] = address;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    firstName,
    lastName,
    image,
    email,
    phone,
    location,
    address,
    createdAt,
    updatedAt,
  ];
}
