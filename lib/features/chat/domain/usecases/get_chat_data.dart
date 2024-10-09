import 'package:dartz/dartz.dart';
import 'package:sound_mind/core/error/failures.dart';
import 'package:sound_mind/features/chat/data/models/chat_message.dart';
import 'package:sound_mind/features/chat/data/models/chat_room.dart';
import 'package:sound_mind/features/chat/domain/repositories/chat_repository.dart';
import '../entities/chat_entity.dart';

class GetChatData {
  final ChatRepository repository;

  GetChatData({required this.repository});

  // Implement call method here
}

class GetUserChatRoomsUseCase {
  final ChatRepository repository;

  GetUserChatRoomsUseCase({required this.repository});

  Future<Either<Failure, List<ChatRoomDto>>> call() async {
    return await repository.getUserChatRooms();
  }
}

class GetChatRoomMessagesUseCase {
  final ChatRepository repository;

  GetChatRoomMessagesUseCase({required this.repository});

  Future<Either<Failure, List<ChatMessageDto>>> call(
      {required int chatroomId}) async {
    return await repository.getChatRoomMessages(chatroomId: chatroomId);
  }
}
