import 'package:anam/data/models/user_model/user_data_model.dart';
import 'package:equatable/equatable.dart';

class GetChatConversationData extends Equatable {
  final List<Conversation>? conversationList;
  final UserDataModel? receiverDataModel;

  const GetChatConversationData({
    required this.conversationList,
    required this.receiverDataModel,
  });

  factory GetChatConversationData.fromJson(Map<String, dynamic> json) {
    return GetChatConversationData(
      conversationList: List<Conversation>.from(
        json["conversation"].map(
          (e) => Conversation.fromJson(e),
        ),
      ),
      receiverDataModel: UserDataModel.fromJson(
        json["reciever"],
      ),
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    conversationList,
    receiverDataModel,
  ];
}

class Conversation extends Equatable {
  final int? id;
  final int? senderId;
  final int? receiverId;
  final String? message;
  final String? createdAt;
  final String? updatedAt;

  const Conversation({
    this.id,
    this.senderId,
    this.receiverId,
    this.message,
    this.createdAt,
    this.updatedAt,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json['id'],
      senderId: json['sender_id'],
      receiverId: json['receiver_id'],
      message: json['message'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        senderId,
        receiverId,
        message,
        createdAt,
        updatedAt,
      ];
}
