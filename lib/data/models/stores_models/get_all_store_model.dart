import 'package:anam/data/models/base_model.dart';
import 'package:anam/data/models/pagination_model.dart';

import 'store_data_model.dart';
class GetAllStoreModel extends BaseResponseModel{
  final StorePaginatedModel? storePaginatedModel;
  const GetAllStoreModel({required super.success, required super.code, required super.message,this.storePaginatedModel, });

  factory GetAllStoreModel.fromJson(Map<String, dynamic> json) {
    return GetAllStoreModel(
      success: json['success'],
      code: json['code'],
      message: json['message'],
      storePaginatedModel: json['result'] != null
          ? StorePaginatedModel.fromJson(json['result'])
          : null,
    );
  }
}
class StorePaginatedModel extends PaginationModel {
  final List<StoreDataModel>? storeList;

  const StorePaginatedModel({
    required super.currentPage,
    required super.lastPage,
    required super.total,
    this.storeList,
  });
  factory StorePaginatedModel.fromJson(Map<String, dynamic> json) {
    return StorePaginatedModel(
      currentPage: json['current_page'],
      lastPage: json['last_page'],
      total: json['total'],
      storeList: json['data'] != null && json['data'].isNotEmpty
          ? List<StoreDataModel>.from(json['data'].map((e) =>StoreDataModel.fromJson(e)))
          : null,
    );
  }
}
