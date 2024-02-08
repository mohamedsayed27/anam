import 'package:equatable/equatable.dart';

class BaseResponseModel extends Equatable{
  final String? message;
  final int? code;
  final bool? success;
  const BaseResponseModel({
    required this.success,
    required this.code,
    required this.message,
  });

  factory BaseResponseModel.fromJson(Map<String, dynamic> json) {
    return BaseResponseModel(
      success: json["success"],
      code: json["code"],
      message: json["message"],
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    success,
    code,
    message,
  ];
}
