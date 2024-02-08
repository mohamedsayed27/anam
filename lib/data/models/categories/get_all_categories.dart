import 'package:anam/data/models/categories/categories_model.dart';

import '../base_model.dart';
import '../pagination_model.dart';

class GetAllCategoriesModel extends BaseResponseModel {
  final GetPaginatedCategoriesResultModel? getPaginatedCategoriesResultModel;

  const GetAllCategoriesModel({
    required super.success,
    required super.code,
    this.getPaginatedCategoriesResultModel,
    required super.message,
  });

  factory GetAllCategoriesModel.fromJson(Map<String, dynamic> json) {
    return GetAllCategoriesModel(
      success: json['success'],
      code: json['code'],
      message: json['message'],
      getPaginatedCategoriesResultModel: GetPaginatedCategoriesResultModel.fromJson(
        json['result'],
      ),
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    success,
    code,
    getPaginatedCategoriesResultModel,
    message,
  ];
}

class GetPaginatedCategoriesResultModel extends PaginationModel {
  final List<CategoriesModel>? categories;

  const GetPaginatedCategoriesResultModel({
    this.categories,
    super.currentPage,
    super.lastPage,
    super.total,
  });

  factory GetPaginatedCategoriesResultModel.fromJson(Map<String, dynamic> json) {
    return GetPaginatedCategoriesResultModel(
      currentPage: json['current_page'],
      lastPage: json['last_page'],
      total: json['total'],
      categories: List<CategoriesModel>.from(json["data"].map((e) => CategoriesModel.fromJson(e)))
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    categories,
    lastPage,
    currentPage,
    total,
  ];
}
