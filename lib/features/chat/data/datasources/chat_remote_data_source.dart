import 'package:sound_mind/features/chat/data/models/chat_message.dart';
import 'package:sound_mind/features/chat/data/models/chat_room.dart';

import '../../../../core/network/network.dart';

abstract class ChatRemoteDataSource {
  Future<List<ChatRoomDto>> getUserChatRooms();
  Future<List<ChatMessageDto>> getChatRoomMessages({required int chatroomId});
}

class ChatRemoteDataSourceImpl extends ChatRemoteDataSource {
  final Network _network;

  ChatRemoteDataSourceImpl({required Network network}) : _network = network;

  @override
  Future<List<ChatRoomDto>> getUserChatRooms() async {
    final response = await _network.call(
      "/UserDashboard/GetUserChatRooms", // API endpoint for chat rooms
      RequestMethod.get,
    );
    return (response.data['data'] as List)
        .map((room) => ChatRoomDto.fromJson(room))
        .toList();
  }

  @override
  Future<List<ChatMessageDto>> getChatRoomMessages(
      {required int chatroomId}) async {
    final response = await _network.call(
      "/UserDashboard/GetUserChatRoomMessages?ChatroomID=$chatroomId", // API endpoint for messages
      RequestMethod.get,
    );
    return (response.data['data'] as List)
        .map((message) => ChatMessageDto.fromJson(message))
        .toList();
  }
}
