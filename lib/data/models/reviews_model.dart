import 'package:anam/data/models/base_model.dart';
import 'package:equatable/equatable.dart';

class GetAllProductReviews extends BaseResponseModel {
  final List<ReviewModel>? reviewModel;

  const GetAllProductReviews({
    required super.success,
    required super.code,
    required super.message,
    required this.reviewModel,
  });

  factory GetAllProductReviews.fromJson(Map<String, dynamic> json) {
    return GetAllProductReviews(
      success: json["success"],
      code: json["code"],
      message: json["message"],
      reviewModel: json["result"] != null && json["result"].isNotEmpty
          ? List<ReviewModel>.from(
              json["result"].map((e) => ReviewModel.fromJson(e)))
          : null,
    );
  }
}

class ReviewModel extends Equatable {
  final int? id;
  final String? name;
  final String? email;
  final int? rate;
  final String? review;
  final String? age;
  final String? address;
  final UserModel? user;
  final String? createdAt;
  final String? updatedAt;

  ReviewModel({
    this.id,
    this.name,
    this.email,
    this.rate,
    this.review,
    this.age,
    this.address,
    this.user,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        rate,
        review,
        age,
        address,
        user,
        createdAt,
        updatedAt,
      ];

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      rate: json['rate'],
      review: json['review'],
      age: json['age'],
      address: json['address'],
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class UserModel extends Equatable {
  final int? id;
  final String? name;
  final String? image;

  const UserModel({
    this.id,
    this.name,
    this.image,
  });

  @override
  List<Object?> get props => [id, name, image];

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}
