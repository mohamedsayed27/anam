import 'package:equatable/equatable.dart';

class MultiLangImageModel extends Equatable {
  final int? id;
  final int? productId;
  final String? createdAt;
  final String? updatedAt;
  final String? imageArEn;

  const MultiLangImageModel({
    this.id,
    this.imageArEn,
    this.productId,
    this.createdAt,
    this.updatedAt,
  });

  factory MultiLangImageModel.fromJson(Map<String, dynamic> json) {
    return MultiLangImageModel(
      id: json['id'],
      imageArEn: json['image'],
      productId: json['product_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  @override
  List<Object?> get props =>
      [id,  imageArEn, productId, createdAt, updatedAt,];
}
class ProductMultiLangImageModel extends Equatable {
  final int? id;
  final int? productId;
  final String? createdAt;
  final String? updatedAt;
  final String? imageAr;
  final String? imageEn;

  const ProductMultiLangImageModel({
    this.id,
    this.imageAr,
    this.imageEn,
    this.productId,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductMultiLangImageModel.fromJson(Map<String, dynamic> json) {
    return ProductMultiLangImageModel(
      id: json['id'],
      imageAr: json['image']["ar"],
      imageEn: json['image']["en"],
      productId: json['product_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  @override
  List<Object?> get props =>
      [id,  imageAr,imageEn, productId, createdAt, updatedAt,];
}
class MultiLangImageArEn extends Equatable{

  final String? imageEn;
  final String? imageAr;

  const MultiLangImageArEn({required this.imageEn, required this.imageAr,});
  factory MultiLangImageArEn.fromJson(Map<String, dynamic> json) {
    return MultiLangImageArEn(
      imageEn: json['en'],
      imageAr: json['ar'],
    );
  }
  @override
  // TODO: implement props
  List<Object?> get props => [
    imageAr,
    imageEn
  ];
}