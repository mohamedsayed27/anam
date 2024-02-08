import 'package:anam/data/models/base_model.dart';
import 'package:anam/data/models/pagination_model.dart';

import '../user_model/user_data_model.dart';

class GetUserFollowingModel extends BaseResponseModel {
  final GetUserFollowingPaginatedModel? getUserFollowingPaginatedModel;

  const GetUserFollowingModel({
    required super.success,
    required super.code,
    required super.message,
    required this.getUserFollowingPaginatedModel,
  });

  factory GetUserFollowingModel.fromJson(Map<String, dynamic> json) {
    return GetUserFollowingModel(
      success: json['success'],
      code: json['code'],
      message: json['message'],
      getUserFollowingPaginatedModel: GetUserFollowingPaginatedModel.fromJson(
        json['result'],
      ),
    );
  }
}

class GetUserFollowingPaginatedModel extends PaginationModel {
  final List<UserDataModel>? userModel;

  const GetUserFollowingPaginatedModel({
    super.currentPage,
    super.lastPage,
    super.total,
    this.userModel,
  });

  factory GetUserFollowingPaginatedModel.fromJson(Map<String, dynamic> json) {
    return GetUserFollowingPaginatedModel(
      currentPage: json['current_page'],
      lastPage: json['last_qpage'],
      total: json['total'],
      userModel: json['data'] != null && json['data'].isNotEmpty
          ? List<UserDataModel>.from(
              json['data'].map((e) => UserDataModel.fromJson(e)))
          : null,
    );
  }
}
