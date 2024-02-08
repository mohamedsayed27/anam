import 'package:equatable/equatable.dart';

import '../products_model/product_model.dart';

class SubCategoriesModel extends Equatable {
  final int? id;
  final String? name;
  final String? image;
  final String? createdAt;
  final String? updatedAt;
  final List<ProductDataModel>? productsList;

  const SubCategoriesModel({
    this.id,
    this.name,
    this.image,
    this.productsList,
    this.createdAt,
    this.updatedAt,
  });

  factory SubCategoriesModel.fromJson(Map<String, dynamic> json) {
    return SubCategoriesModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      productsList: List<ProductDataModel>.from(json['products'].map((e) => ProductDataModel.fromJson(e))),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    name,
    image,
    createdAt,
    updatedAt,
  ];
}
