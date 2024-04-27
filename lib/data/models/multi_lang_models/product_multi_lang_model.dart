import 'package:equatable/equatable.dart';

import 'image_multi_lang_model.dart';

class ProductMultiLangModel extends Equatable {
  final int? id;
  final Map<String, String>? name;
  final int? regularPrice;
  final int? salePrice;
  final Map<String, String>? description;
  final String? youtubeLink;
  final Map<String, String>? advantages;
  final Map<String, String>? defects;
  final Map<String, String>? location;
  final Map<String, String>? mainImage;
  final int? isApproved;
  final int? inStock;
  final String? coordinates;
  final String? mapLocation;
  final int? uploadedById;
  final int? categoryId;
  final List<MultiLangImageModel>? images;
  final int? subCategoryId;
  final int? statusId;
  final String? createdAt;
  final String? updatedAt;

  const ProductMultiLangModel({
    this.id,
    this.name,
    this.regularPrice,
    this.salePrice,
    this.images,
    this.description,
    this.youtubeLink,
    this.advantages,
    this.defects,
    this.location,
    this.mainImage,
    this.isApproved,
    this.inStock,
    this.coordinates,
    this.mapLocation,
    this.uploadedById,
    this.categoryId,
    this.subCategoryId,
    this.statusId,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        regularPrice,
        salePrice,
        description,
        youtubeLink,
        advantages,
        defects,
        location,
        mainImage,
        isApproved,
        inStock,
        coordinates,
        mapLocation,
        uploadedById,
        categoryId,
        subCategoryId,
        statusId,
        createdAt,
        updatedAt,
      ];

  factory ProductMultiLangModel.fromJson(Map<String, dynamic> json) {
    return ProductMultiLangModel(
      id: json['id'],
      name:
          json['name'] != null ? Map<String, String>.from(json['name']) : null,
      regularPrice: json['regular_price'],
      salePrice: json['sale_price'],
      description: json['description'] != null
          ? Map<String, String>.from(json['description'])
          : null,
      youtubeLink: json['youtube_link'],
      advantages: json['advantages'] != null
          ? Map<String, String>.from(json['advantages'])
          : null,
      defects: json['defects'] != null
          ? Map<String, String>.from(json['defects'])
          : null,
      location: json['location'] != null
          ? Map<String, String>.from(json['location'])
          : null,
      mainImage: json['main_image'] != null
          ? Map<String, String>.from(json['main_image'])
          : null,
      isApproved: json['is_approved'],
      inStock: json['in_stock'],
      coordinates: json['coordinates'],
      images: json['images'].isNotEmpty && json['images'] != null
          ? List<MultiLangImageModel>.from(
              json['images'].map((e) => MultiLangImageModel.fromJson(e)),
            )
          : null,
      mapLocation: json['map_location'],
      uploadedById: json['uploaded_by_id'],
      categoryId: json['category_id'],
      subCategoryId: json['sub_category_id'],
      statusId: json['status_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if(id!=null)'id': id,
      'name': name,
      'regular_price': regularPrice,
      'sale_price': salePrice,
      'description': description,
      'youtube_link': youtubeLink,
      'advantages': advantages,
      'defects': defects,
      'location': location,
      'main_image': mainImage,
      'is_approved': isApproved,
      'in_stock': inStock,
      'coordinates': coordinates,
      'map_location': mapLocation,
      'uploaded_by_id': uploadedById,
      'category_id': categoryId,
      if(subCategoryId!=null)'sub_category_id': subCategoryId,
      'status_id': statusId,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
