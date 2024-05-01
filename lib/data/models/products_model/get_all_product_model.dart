import '../base_model.dart';
import '../pagination_model.dart';
import 'product_model.dart';

class GetAllProductModel extends BaseResponseModel {
  final GetPaginatedProductResultModel? getPaginatedProductResultModel;

  const GetAllProductModel({
    required super.success,
    required super.code,
    this.getPaginatedProductResultModel,
    required super.message,
  });

  factory GetAllProductModel.fromJson(Map<String, dynamic> json) {
    return GetAllProductModel(
      success: json['success'],
      code: json['code'],
      message: json['message'],
      getPaginatedProductResultModel: GetPaginatedProductResultModel.fromJson(
        json['result'],
      ),
    );
  }
}

class GetPaginatedProductResultModel extends PaginationModel {
  final List<ProductDataModel>? products;

  const GetPaginatedProductResultModel({
    this.products = const [],
    super.currentPage,
    super.lastPage,
    super.total,
  });

  factory GetPaginatedProductResultModel.fromJson(Map<String, dynamic> json) {
    return GetPaginatedProductResultModel(
      currentPage: json['current_page'],
      lastPage: json['last_page'],
      total: json['total'],
      products: List<ProductDataModel>.from(json["data"].map((e) => ProductDataModel.fromJson(e))),
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        products,
        lastPage,
        currentPage,
        total,
      ];
}
