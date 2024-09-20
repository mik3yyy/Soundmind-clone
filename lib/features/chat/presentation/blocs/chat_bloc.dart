import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/usecases/get_chat_data.dart';

part 'chat_event.dart';
part 'chat_state.dart';


class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetChatData getChatData;

  ChatBloc({
  required this.getChatData
  }) : super(ChatInitial());

}
