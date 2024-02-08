import 'package:anam/data/models/base_model.dart';
import 'package:anam/data/models/laborers_models/laborer_model.dart';
import 'package:anam/data/models/pagination_model.dart';

class GetAllLaborersModel extends BaseResponseModel {
  final LaborerPaginatedModel? storePaginatedModel;

  const GetAllLaborersModel({
    required super.success,
    required super.code,
    required super.message,
    this.storePaginatedModel,
  });

  factory GetAllLaborersModel.fromJson(Map<String, dynamic> json) {
    return GetAllLaborersModel(
      success: json['success'],
      code: json['code'],
      message: json['message'],
      storePaginatedModel: json['result'] != null
          ? LaborerPaginatedModel.fromJson(json['result'])
          : null,
    );
  }
}

class LaborerPaginatedModel extends PaginationModel {
  final List<LaborerModel>? laborerList;

  const LaborerPaginatedModel({
    required super.currentPage,
    required super.lastPage,
    required super.total,
    this.laborerList,
  });

  factory LaborerPaginatedModel.fromJson(Map<String, dynamic> json) {
    return LaborerPaginatedModel(
      currentPage: json['current_page'],
      lastPage: json['last_page'],
      total: json['total'],
      laborerList: json['data'] != null && json['data'].isNotEmpty
          ? List<LaborerModel>.from(
              json['data'].map((e) => LaborerModel.fromJson(e)))
          : null,
    );
  }
}

