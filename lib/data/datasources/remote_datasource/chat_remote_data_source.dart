import 'package:anam/data/models/base_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/constants/constants.dart';
import '../../../core/error/error_exception.dart';
import '../../../core/network/api_end_points.dart';
import '../../../core/network/dio_helper.dart';
import '../../../core/network/error_message_model.dart';
import '../../models/chat_models/chat_item_model.dart';
import '../../models/chat_models/conversation_model.dart';

class ChatRemoteDataSource {
  final DioHelper dioHelper;

  ChatRemoteDataSource({
    required this.dioHelper,
  });

  Future<Either<ErrorException, GetChatConversationData>> getChatData({
    required int receiverId,
  }) async {
    try {
      final response = await dioHelper.getData(
        url: "${EndPoints.show}/$userId/$receiverId",
        token: token,
      );

      return Right(GetChatConversationData.fromJson(response.data["result"],));
    } catch (e) {
      if (e is DioException) {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel.fromJson(e.response!.data),
          ),
        );
      } else {
        rethrow;
      }
    }
  }


  Future<Either<ErrorException, GetAllChatListModel>> getChatList({
    required int pageNumber
}) async {
    try {
      final response = await dioHelper.getData(
        url: "${EndPoints.userChats}?page=$pageNumber",
        token: token,
      );

      return Right(GetAllChatListModel.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel.fromJson(e.response!.data),
          ),
        );
      } else {
        rethrow;
      }
    }
  }

  Future<Either<ErrorException, BaseResponseModel>> sendMessage({
    required int receiverId,
    required String message,
  }) async {
    try {
      final response = await dioHelper.postData(
        url: EndPoints.chats,
        data: FormData.fromMap({
          "sender_id":userId,
          "reciever_id":receiverId,
          "message":message,
        }),
        token: token,
      );

      return Right(BaseResponseModel.fromJson(response.data,));
    } catch (e) {
      if (e is DioException) {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel.fromJson(e.response!.data),
          ),
        );
      } else {
        rethrow;
      }
    }
  }
}
