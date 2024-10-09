import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sound_mind/core/error/failures.dart';
import 'package:sound_mind/features/chat/data/models/chat_room.dart';
import 'package:sound_mind/features/chat/domain/usecases/get_chat_data.dart';

part 'get_user_chat_rooms_state.dart';

// Cubit for GetUserChatRoomsUseCase
class GetUserChatRoomsCubit extends Cubit<GetUserChatRoomsState> {
  final GetUserChatRoomsUseCase getUserChatRoomsUseCase;

  GetUserChatRoomsCubit({required this.getUserChatRoomsUseCase})
      : super(GetUserChatRoomsInitial());

  Future<void> fetchUserChatRooms() async {
    emit(GetUserChatRoomsLoading());
    final result = await getUserChatRoomsUseCase.call();
    result.fold(
      (failure) => emit(GetUserChatRoomsError(failure: failure)),
      (chatRooms) => emit(GetUserChatRoomsLoaded(chatRooms: chatRooms)),
    );
  }
}
