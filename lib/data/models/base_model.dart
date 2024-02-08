import '../../domain/entities/base.dart';

class BaseResponseModel extends BaseResponseEntity {
  const BaseResponseModel({
    required super.success,
    required super.code,
    required super.message,
  });

  factory BaseResponseModel.fromJson(Map<String, dynamic> json) {
    return BaseResponseModel(
      success: json["success"],
      code: json["code"],
      message: json["message"],
    );
  }
}
