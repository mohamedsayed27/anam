part of 'chat_cubit.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}
class GetChatLoading extends ChatState {}
class GetChatSuccess extends ChatState {}
class GetChatError extends ChatState {}
class SendMessageLoading extends ChatState {}
class SendMessageSuccess extends ChatState {}
class SendMessageError extends ChatState {}
