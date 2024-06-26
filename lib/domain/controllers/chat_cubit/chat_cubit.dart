import 'package:anam/core/constants/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../../../core/services/services_locator.dart';
import '../../../data/datasources/remote_datasource/chat_remote_data_source.dart';
import '../../../data/models/chat_models/chat_item_model.dart';
import '../../../data/models/chat_models/conversation_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  static ChatCubit get(context) => BlocProvider.of(context);

  final ChatRemoteDataSource _chatRemoteDataSource = sl();

  List<Conversation>? conversationsList;

  bool getChat = false;
  void getChats({required int receiverId}) async {
    getChat = true;
    emit(GetChatLoading());
    final response = await _chatRemoteDataSource.getChatData(
      receiverId: receiverId,
    );
    response.fold((l) {
      getChat = false;
      emit(GetChatError());
    }, (r) {
      getChat = false;
      print(r);
      conversationsList = r.conversationList??[];
      print(conversationsList);
      emit(GetChatSuccess());
    });
  }
  List<ChatItemModel> chatsItemsList = [];
  int allChatsItemsPageNumber = 1;
  bool getChatItemsLoading = false;
  void getChatList() async {
    getChatItemsLoading = true;
    if(allChatsItemsPageNumber==1){
      chatsItemsList.clear();
    }
    emit(GetChatLoading());
    final response = await _chatRemoteDataSource.getChatList(pageNumber: allChatsItemsPageNumber);
    response.fold((l) {
      getChatItemsLoading = false;
      emit(GetChatError());
    }, (r) {
      getChatItemsLoading = false;
      print(r);

      if(r.chatPaginatedModel?.chatsList!=null){
        if (allChatsItemsPageNumber <=
            r.chatPaginatedModel!.lastPage!) {
          if (r.chatPaginatedModel!.currentPage! <=
              r.chatPaginatedModel!.lastPage!) {
            r.chatPaginatedModel?.chatsList?.forEach((element) {
              print(element.id.toString());
              if(element.id.toString()!=userId) {
                chatsItemsList.add(element);
              }
            });
          }
          allChatsItemsPageNumber++;
        }
      }
      print(chatsItemsList);
      emit(GetChatSuccess());
    });
  }

  void addMessage({required Conversation conversation}){
    print(conversation);
    conversationsList!.insert(0,conversation);
    emit(AddMessageState());
  }
//   void channelSubscription({
//     required int receiverId,
//     required int senderId,
// })async{
//     PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
//     final  list = <int>[receiverId, senderId]..sort();
//     try {
//       await pusher.init(
//         apiKey: "d7e9da7b3bc9de6317b3",
//         cluster: "eu",
//
//         // onConnectionStateChange: onConnectionStateChange,
//         // onError: (),
//         onSubscriptionSucceeded: (String channelName, dynamic data) {
//           print("onSubscriptionSucceeded: $channelName data: $data");
//         },
//         onEvent: (PusherEvent event) {
//           print("onEvent: $event");
//         },
//         onSubscriptionError: (String message, dynamic e) {
//           print("onSubscriptionError: $message Exception: $e");
//         },
//         onDecryptionFailure: (error, data){
//
//         },
//         onMemberAdded: (error, pusherMember){
//
//         },
//         onConnectionStateChange: (dynamic currentState, dynamic previousState) {
//           print("Connection: $currentState");
//         },
//         onMemberRemoved: (error, pusherMember){
//
//         },
//         // authEndpoint: "<Your Authendpoint>",
//         // onAuthorizer: onAuthorizer
//       );
//       await pusher.subscribe(channelName: "private.chat.${list.first}.${list.last}");
//       await pusher.connect();
//     } catch (e) {
//       print("ERROR: $e");
//     }
//     print(pusher.connectionState);
//
//
//
//     // print(pusher.channels);
//
//     // print(pp.members);
//   }
  void sendMessage({required int receiverId, required String message}) async {
    emit(SendMessageLoading());
    final response = await _chatRemoteDataSource.sendMessage(
      receiverId: receiverId,
      message: message,
    );
    response.fold((l) {
      emit(SendMessageError());
    }, (r) {
      emit(SendMessageSuccess());
    });
  }
}
