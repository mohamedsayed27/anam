import 'package:anam/data/models/base_model.dart';
import 'package:equatable/equatable.dart';

import '../user_model/user_data_model.dart';

class LoginAndRegisterModel extends BaseResponseModel {
  final LoginAndRegisterDataModel? loginAndRegisterDataModel;

  const LoginAndRegisterModel({
    required super.success,
    required super.code,
    required super.message,
    required this.loginAndRegisterDataModel,
  });

  factory LoginAndRegisterModel.fromJson(Map<String, dynamic> json) {
    return LoginAndRegisterModel(
      success: json["success"],
      code: json["code"],
      message: json["message"],
      loginAndRegisterDataModel: LoginAndRegisterDataModel.fromJson(json['result']),
    );
  }
}

class LoginAndRegisterDataModel extends Equatable {
  final String? token;
  final String? tokenType;
  final int? expiresIn;
  final UserDataModel? user;

  const LoginAndRegisterDataModel({
    this.token,
    this.tokenType,
    this.expiresIn,
    this.user,
  });

  factory LoginAndRegisterDataModel.fromJson(Map<String, dynamic> json) {
    return LoginAndRegisterDataModel(
      token: json['token'],
      tokenType: json['token_type'],
      expiresIn: json['expires_in'],
      user: UserDataModel.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['token_type'] = tokenType;
    data['expires_in'] = expiresIn;
    data['user'] = user;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        token,
        tokenType,
        expiresIn,
        user,
      ];
}
