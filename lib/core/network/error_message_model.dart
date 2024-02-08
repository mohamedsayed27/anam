import 'package:equatable/equatable.dart';

class BaseErrorModel extends Equatable {
  final String message;
  final bool success;
  final int code;
  final List<String>? errors;
  const BaseErrorModel({
    required this.message,
    required this.success,
    required this.code,
    required this.errors,
  });

  factory BaseErrorModel.fromJson(Map<String, dynamic> json) {
    return BaseErrorModel(
      message: json['message'],
      code: json['code'],
      success: json['success'],
        errors: json['errors']!=null?List<String>.from(json['errors']?.map((e) => e)):null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "message": message,
      "code": code,
      "success": success,
      "errors": errors,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        message,
        success,
        errors,
        code,
      ];
}
