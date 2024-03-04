import 'package:anam/core/constants/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../../../core/services/services_locator.dart';
import '../../../data/datasources/remote_datasource/chat_remote_data_source.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  static ChatCubit get(context) => BlocProvider.of(context);

  final ChatRemoteDataSource _chatRemoteDataSource = sl();

  void getChats({required int receiverId}) async {
    emit(GetChatLoading());
    final response = await _chatRemoteDataSource.getChatData(
      receiverId: receiverId,
    );
    response.fold((l) {
      emit(GetChatError());
      print(l);
    }, (r) {
      emit(GetChatSuccess());
      print(r);
    });
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
      print(l);
    }, (r) {
      emit(SendMessageSuccess());
      print(r);
    });
  }
}
