import 'package:equatable/equatable.dart';

class AccountDataModel extends Equatable {
  final int? id;
  final String? name;
  final String? image;
  final String? email;
  final String? phone;
  final String? location;
  final String? address;
  final int? active;
  final String? remainingItems;
  final String? subscriptionStartDate;
  final String? subscriptionEndDate;
  final int? socialId;
  final String? socialType;
  final String? emailVerifiedAt;
  final String? birthDate;
  final String? createdAt;
  final String? updatedAt;
  final int? countryId;
  final int? cityId;
  final int? stateId;
  final int? packageId;

  const AccountDataModel({
    this.id,
    this.name,
    this.image,
    this.email,
    this.phone,
    this.location,
    this.address,
    this.active,
    this.remainingItems,
    this.subscriptionStartDate,
    this.subscriptionEndDate,
    this.socialId,
    this.socialType,
    this.emailVerifiedAt,
    this.birthDate,
    this.createdAt,
    this.updatedAt,
    this.countryId,
    this.cityId,
    this.stateId,
    this.packageId,
  });

  factory AccountDataModel.fromJson(Map<String, dynamic> json) {
    return AccountDataModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      email: json['email'],
      phone: json['phone'],
      location: json['location'],
      address: json['address'],
      active: json['active'],
      remainingItems: json['remaining_items'],
      subscriptionStartDate: json['subscription_start_date'],
      subscriptionEndDate: json['subscription_end_date'],
      socialId: json['social_id'],
      socialType: json['social_type'],
      emailVerifiedAt: json['email_verified_at'],
      birthDate: json['birth_date'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      countryId: json['country_id'],
      cityId: json['city_id'],
      stateId: json['state_id'],
      packageId: json['package_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['email'] = email;
    data['phone'] = phone;
    data['location'] = location;
    data['address'] = address;
    data['active'] = active;
    data['remaining_items'] = remainingItems;
    data['subscription_start_date'] = subscriptionStartDate;
    data['subscription_end_date'] = subscriptionEndDate;
    data['social_id'] = socialId;
    data['social_type'] = socialType;
    data['email_verified_at'] = emailVerifiedAt;
    data['birth_date'] = birthDate;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['country_id'] = countryId;
    data['city_id'] = cityId;
    data['state_id'] = stateId;
    data['package_id'] = packageId;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    name,
    image,
    email,
    phone,
    location,
    address,
    active,
    remainingItems,
    subscriptionStartDate,
    subscriptionEndDate,
    socialId,
    socialType,
    emailVerifiedAt,
    birthDate,
    createdAt,
    updatedAt,
    countryId,
    cityId,
    stateId,
    packageId,
  ];
}
