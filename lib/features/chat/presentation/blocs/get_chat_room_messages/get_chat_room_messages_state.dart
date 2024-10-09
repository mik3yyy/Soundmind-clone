part of 'get_chat_room_messages_cubit.dart';

// States for GetChatRoomMessagesCubit
abstract class GetChatRoomMessagesState {}

class GetChatRoomMessagesInitial extends GetChatRoomMessagesState {}

class GetChatRoomMessagesLoading extends GetChatRoomMessagesState {}

class GetChatRoomMessagesLoaded extends GetChatRoomMessagesState {
  final List<ChatMessageDto> messages;

  GetChatRoomMessagesLoaded({required this.messages});
}

class GetChatRoomMessagesError extends GetChatRoomMessagesState {
  final Failure failure;

  GetChatRoomMessagesError({required this.failure});
}
