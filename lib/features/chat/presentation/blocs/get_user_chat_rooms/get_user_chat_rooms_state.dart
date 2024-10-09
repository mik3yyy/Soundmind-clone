part of 'get_user_chat_rooms_cubit.dart';

abstract class GetUserChatRoomsState {}

class GetUserChatRoomsInitial extends GetUserChatRoomsState {}

class GetUserChatRoomsLoading extends GetUserChatRoomsState {}

class GetUserChatRoomsLoaded extends GetUserChatRoomsState {
  final List<ChatRoomDto> chatRooms;

  GetUserChatRoomsLoaded({required this.chatRooms});
}

class GetUserChatRoomsError extends GetUserChatRoomsState {
  final Failure failure;

  GetUserChatRoomsError({required this.failure});
}
