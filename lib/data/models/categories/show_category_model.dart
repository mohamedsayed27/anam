import 'package:anam/data/models/base_model.dart';
import 'package:anam/data/models/categories/sub_categories_model.dart';
import 'package:anam/data/models/products_model/product_model.dart';
import 'package:equatable/equatable.dart';
class ShowCategoryModel extends BaseResponseModel{
  final ShowCategoryDataModel? showCategoryDataModel;
  const ShowCategoryModel({required super.success, required super.code, required super.message,required this.showCategoryDataModel});
  factory ShowCategoryModel.fromJson(Map<String, dynamic> json){
    return ShowCategoryModel(success: json['success'],
      code: json['code'],
      message: json['message'],
      showCategoryDataModel: ShowCategoryDataModel.fromJson(
        json['result'],
      ),);
  }

}
class ShowCategoryDataModel extends Equatable {
  final int? id;
  final String? name;
  final String? image;
  final List<SubCategoriesModel> ?subCategories;
  final List<ProductDataModel> ?products;

  const ShowCategoryDataModel({
    required this.id,
    required this.name,
    required this.image,
    required this.subCategories,
    required this.products,
  });

  @override
  List<Object?> get props => [id, name, image, subCategories, products,];

  factory ShowCategoryDataModel.fromJson(Map<String, dynamic> json) {
    return ShowCategoryDataModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      subCategories: (json['sub_categories'] as List<dynamic>?)
              ?.map((subCategory) => SubCategoriesModel.fromJson(subCategory))
              .toList() ??
          [],
      products: (json['products'] as List<dynamic>?)
              ?.map((product) => ProductDataModel.fromJson(product))
              .toList() ??
          [],
    );
  }
}
