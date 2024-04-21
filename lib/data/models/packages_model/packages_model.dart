import 'package:anam/data/models/base_model.dart';
import 'package:equatable/equatable.dart';

class GetAllPackagesModel extends BaseResponseModel {
  final List<MonthlyPackage>? monthlyPackage;

  const GetAllPackagesModel({
    required super.success,
    required super.code,
    required super.message,
    required this.monthlyPackage,
  });

  factory GetAllPackagesModel.fromJson(Map<String, dynamic> json) {
    return GetAllPackagesModel(
      success: json["success"],
      code: json["code"],
      message: json["message"],
      monthlyPackage: json['result'] != null && json['result'].isNotEmpty
          ? List<MonthlyPackage>.from(
              json['result'].map((e) => MonthlyPackage.fromJson(e)))
          : null,
    );
  }
}

class MonthlyPackage extends Equatable {
  final int? id;
  final String? title;
  final String? description;
  final double? price;
  final int? duration;
  final int? productsCount;
  final String? createdAt;
  final String? updatedAt;

  MonthlyPackage({
    this.id,
    this.title,
    this.description,
    this.price,
    this.duration,
    this.productsCount,
    this.createdAt,
    this.updatedAt,
  });

  factory MonthlyPackage.fromJson(Map<String, dynamic> json) {
    return MonthlyPackage(
      id: json['id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      duration: json['duration'] as int?,
      productsCount: json['products_count'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        price,
        duration,
        productsCount,
        createdAt,
        updatedAt,
      ];
}
