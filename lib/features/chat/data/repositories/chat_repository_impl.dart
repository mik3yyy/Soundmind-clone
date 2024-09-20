import 'package:dartz/dartz.dart';
import 'package:sound_mind/core/error/failures.dart';
import 'package:sound_mind/core/utils/typedef.dart';
import 'package:sound_mind/features/Chat/data/datasources/chat_remote_data_source.dart';
import 'package:sound_mind/features/chat/data/models/chat_message.dart';
import 'package:sound_mind/features/chat/data/models/chat_room.dart';
import 'package:sound_mind/features/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl extends ChatRepository {
  final ChatRemoteDataSource _remoteDataSource;

  ChatRepositoryImpl({required ChatRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  @override
  ResultFuture<List<ChatRoomDto>> getUserChatRooms() async {
    try {
      final chatRooms = await _remoteDataSource.getUserChatRooms();
      return Right(chatRooms);
    } catch (error) {
      return const Left(ServerFailure("Failed to fetch chat rooms"));
    }
  }

  @override
  ResultFuture<List<ChatMessageDto>> getChatRoomMessages(
      {required int chatroomId}) async {
    try {
      final messages =
          await _remoteDataSource.getChatRoomMessages(chatroomId: chatroomId);
      return Right(messages);
    } catch (error) {
      return const Left(ServerFailure("Failed to fetch chat messages"));
    }
  }
}
