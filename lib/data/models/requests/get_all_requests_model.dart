import 'package:anam/data/models/base_model.dart';
import 'package:equatable/equatable.dart';

import '../pagination_model.dart';
import 'request_model.dart';

class GetAllRequestsModel extends BaseResponseModel {
  final RequestsPaginatedModel? requestsPaginatedModel;

  const GetAllRequestsModel({
    required super.success,
    required super.code,
    required super.message,
    this.requestsPaginatedModel,
  });
  factory GetAllRequestsModel.fromJson(Map<String, dynamic> json) {
    return GetAllRequestsModel(
      success: json["success"],
      code: json["code"],
      message: json["message"],
      requestsPaginatedModel: RequestsPaginatedModel.fromJson(json["result"]),
    );
  }
}

class RequestsPaginatedModel extends PaginationModel {
  final List<RequestModel>? requestModel;

  const RequestsPaginatedModel({
    required super.currentPage,
    required super.lastPage,
    required super.total,
    required this.requestModel,
  });

  factory RequestsPaginatedModel.fromJson(Map<String, dynamic> json) {
    return RequestsPaginatedModel(
      currentPage: json['current_page'],
      lastPage: json['last_page'],
      total: json['total'],
      requestModel: json['data']!=null&&json['data'].isNotEmpty?List<RequestModel>.from(json['data'].map((e) => RequestModel.fromJson(e))):null,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        currentPage,
        lastPage,
        total,
        requestModel,
      ];
}
