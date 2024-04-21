import 'package:anam/data/models/pagination_model.dart';
import 'package:equatable/equatable.dart';

import '../base_model.dart';

class GetAllChatListModel extends BaseResponseModel {
  final ChatPaginatedModel? chatPaginatedModel;

  const GetAllChatListModel({
    required super.success,
    required super.code,
    required super.message,
    this.chatPaginatedModel,
  });

  factory GetAllChatListModel.fromJson(Map<String, dynamic> json) {
    return GetAllChatListModel(
      success: json['success'],
      code: json['code'],
      message: json['message'],
      chatPaginatedModel: json['result'] != null
          ? ChatPaginatedModel.fromJson(json['result'])
          : null,
    );
  }
}
class ChatPaginatedModel extends PaginationModel {
  final List<ChatItemModel>? chatsList;

  const ChatPaginatedModel({
    required this.chatsList,
    super.currentPage,
    super.lastPage,
    super.total,
  });

  factory ChatPaginatedModel.fromJson(Map<String, dynamic> json) {
    return ChatPaginatedModel(
      currentPage: json['current_page'],
      lastPage: json['last_page'],
      total: json['total'],
      chatsList: json['data'] != null && json['data'].isNotEmpty
          ? List<ChatItemModel>.from(
          json['data'].map((e) => ChatItemModel.fromJson(e)))
          : null,
    );
  }
}

class ChatItemModel extends Equatable {
  final int? id;
  final String? name;
  final String? image;
  final String? email;
  final String? phone;
  final String? location;
  final String? address;
  final String? socialId;
  final String? socialType;
  final String? vendorPage;
  final String? type;
  final String? createdAt;
  final String? updatedAt;

  const ChatItemModel({
    this.id,
    this.name,
    this.image,
    this.email,
    this.phone,
    this.location,
    this.address,
    this.socialId,
    this.socialType,
    this.vendorPage,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  factory ChatItemModel.fromJson(Map<String, dynamic> json) {
    return ChatItemModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      location: json['location'] as String?,
      address: json['address'] as String?,
      socialId: json['social_id'] as String?,
      socialType: json['social_type'] as String?,
      vendorPage: json['vendor_page'] as String?,
      type: json['type'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        image,
        email,
        phone,
        location,
        address,
        socialId,
        socialType,
        vendorPage,
        type,
        createdAt,
        updatedAt,
      ];
}
