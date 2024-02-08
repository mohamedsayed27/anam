import 'package:anam/data/models/base_model.dart';
import 'package:anam/data/models/products_model/product_model.dart';
import 'package:equatable/equatable.dart';

class GetVendorDetailsWidget extends BaseResponseModel {
  final VendorProfileModel vendorProfileModel;

  const GetVendorDetailsWidget({
    required super.success,
    required super.code,
    required super.message,
    required this.vendorProfileModel,
  });

  factory GetVendorDetailsWidget.fromJson(Map<String, dynamic> json) {
    return GetVendorDetailsWidget(
      success: json["success"],
      code: json["code"],
      message: json["message"],
      vendorProfileModel: VendorProfileModel.fromJson(
        json['result'],
      ),
    );
  }
}

class VendorProfileModel extends Equatable {
  final int? id;
  final String? name;
  final String? image;
  final String? email;
  final String? phone;
  final String? location;
  final String? address;
  final String? socialId;
  final String? socialType;
  final List<DataModel>? stores;
  final List<DataModel>? laborers;
  final List<DataModel>? veterinarians;
  final String? createdAt;
  final String? updatedAt;
  final bool? isFollowed;
  final int? reviewsNumber;
  final int? averageRating;
  final int? followersCount;
  final List<ProductDataModel>? productsList;

  const VendorProfileModel({
    this.id,
    this.name,
    this.image,
    this.email,
    this.phone,
    this.location,
    this.address,
    this.socialId,
    this.productsList,
    this.socialType,
    this.averageRating,
    this.followersCount,
    this.isFollowed,
    this.reviewsNumber,
    this.stores,
    this.laborers,
    this.veterinarians,
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
        stores,
        laborers,
        veterinarians,
        createdAt,
        updatedAt,
      ];

  factory VendorProfileModel.fromJson(Map<String, dynamic> json) {
    return VendorProfileModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      location: json['location'] as String?,
      averageRating: json['average_rating'] as int?,
      isFollowed: json['is_followed'] as bool?,
      followersCount: json['followers_count'] as int?,
      reviewsNumber: json['reviews_number'] as int?,
      address: json['address'] as String?,
      socialId: json['social_id'] as String?,
      socialType: json['social_type'] as String?,
      productsList: json['products'] != null && json['products'].isNotEmpty
          ? List<ProductDataModel>.from(json['products'].map((e) => ProductDataModel.fromJson(e)))
          : null,
      stores: (json['stores'] as List<dynamic>?)
          ?.map((store) => DataModel.fromJson(store))
          .toList(),
      laborers: (json['laborers'] as List<dynamic>?)
          ?.map((laborer) => DataModel.fromJson(laborer))
          .toList(),
      veterinarians: (json['veterinarians'] as List<dynamic>?)
          ?.map((veterinarian) => DataModel.fromJson(veterinarian))
          .toList(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
}

class DataModel extends Equatable {
  final int? id;
  final String? image;

  const DataModel({
    this.id,
    this.image,
  });

  @override
  List<Object?> get props => [id, image];

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json['id'] as int?,
      image: json['image'] as String?,
    );
  }
}
