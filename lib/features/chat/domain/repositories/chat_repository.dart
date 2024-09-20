import 'package:sound_mind/core/utils/typedef.dart';
import 'package:sound_mind/features/chat/data/models/chat_message.dart';
import 'package:sound_mind/features/chat/data/models/chat_room.dart';

abstract class ChatRepository {
  // Fetch all chat rooms the user is part of
  ResultFuture<List<ChatRoomDto>> getUserChatRooms();

  // Fetch all messages for a specific chat room
  ResultFuture<List<ChatMessageDto>> getChatRoomMessages(
      {required int chatroomId});
}
