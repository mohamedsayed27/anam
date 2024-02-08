import 'package:equatable/equatable.dart';

class CategoriesModel extends Equatable {
  final int? id;
  final String? name;
  final String? image;
  final String? parentCategory;
  final String? createdAt;
  final String? updatedAt;

  const CategoriesModel({
    this.id,
    this.name,
    this.image,
    this.parentCategory,
    this.createdAt,
    this.updatedAt,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      parentCategory: json['parent_category'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['parent_category'] = parentCategory;
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
    parentCategory,
    createdAt,
    updatedAt,
  ];
}
