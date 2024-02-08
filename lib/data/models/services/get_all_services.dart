import 'package:anam/data/models/base_model.dart';
import 'package:anam/data/models/pagination_model.dart';
import 'package:anam/data/models/services/services_model.dart';

class GetAllServicesModel extends BaseResponseModel{
  final ServicesPaginatedModel? servicesPaginatedModel;
  const GetAllServicesModel({required super.success, required super.code, required super.message,this.servicesPaginatedModel, });

  factory GetAllServicesModel.fromJson(Map<String, dynamic> json) {
    return GetAllServicesModel(
      success: json['success'],
      code: json['code'],
      message: json['message'],
      servicesPaginatedModel: json['result'] != null
          ? ServicesPaginatedModel.fromJson(json['result'])
          : null,
    );
  }
}
class ServicesPaginatedModel extends PaginationModel {
  final List<ServiceModel>? allServicesList;

  const ServicesPaginatedModel({
    required super.currentPage,
    required super.lastPage,
    required super.total,
    this.allServicesList,
  });
  factory ServicesPaginatedModel.fromJson(Map<String, dynamic> json) {
    return ServicesPaginatedModel(
      currentPage: json['current_page'],
      lastPage: json['last_page'],
      total: json['total'],
      allServicesList: json['data'] != null && json['data'].isNotEmpty
          ? List<ServiceModel>.from(json['data'].map((e) =>ServiceModel.fromJson(e)))
          : null,
    );
  }
}
