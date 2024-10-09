import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sound_mind/core/error/failures.dart';
import 'package:sound_mind/features/chat/data/models/chat_message.dart';
import 'package:sound_mind/features/chat/domain/usecases/get_chat_data.dart';

part 'get_chat_room_messages_state.dart';

class GetChatRoomMessagesCubit extends Cubit<GetChatRoomMessagesState> {
  final GetChatRoomMessagesUseCase getChatRoomMessagesUseCase;

  GetChatRoomMessagesCubit({required this.getChatRoomMessagesUseCase})
      : super(GetChatRoomMessagesInitial());

  Future<void> fetchChatRoomMessages(int chatroomId) async {
    emit(GetChatRoomMessagesLoading());
    final result =
        await getChatRoomMessagesUseCase.call(chatroomId: chatroomId);
    result.fold(
      (failure) => emit(GetChatRoomMessagesError(failure: failure)),
      (messages) => emit(GetChatRoomMessagesLoaded(messages: messages)),
    );
  }
}
