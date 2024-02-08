import 'package:anam/data/models/base_model.dart';

import 'product_model.dart';

class UploadOrUpdateProductModel extends BaseResponseModel {
  final ProductDataModel? productDataModel;

  const UploadOrUpdateProductModel({
    required super.success,
    required super.code,
    required super.message,
    this.productDataModel,
  });

  factory UploadOrUpdateProductModel.fromJson(Map<String, dynamic> json) {
    return UploadOrUpdateProductModel(
      success: json['success'],
      code: json['code'],
      message: json['message'],
      productDataModel: ProductDataModel.fromJson(
        json["result"],
      ),
    );
  }
}


