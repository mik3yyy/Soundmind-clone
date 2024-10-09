import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_mind/core/extensions/context_extensions.dart';
import 'package:sound_mind/core/extensions/widget_extensions.dart';
import 'package:sound_mind/features/appointment/presentation/views/appointment_page.dart';
import 'package:sound_mind/features/chat/presentation/blocs/get_user_chat_rooms/get_user_chat_rooms_cubit.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<GetUserChatRoomsCubit>().fetchUserChatRooms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Page'),
      ),
      body: BlocBuilder<GetUserChatRoomsCubit, GetUserChatRoomsState>(
        builder: (context, state) {
          if (state is GetUserChatRoomsLoaded) {
            return Column(
              children: [
                Gap(10),
                ListView.builder(
                  itemCount: state.chatRooms.length,
                  itemBuilder: (context, index) {
                    var chatRoom = state.chatRooms[index];
                    return ListTile(
                      onTap: () {},
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundColor: context.colors.greyDecor,
                      ),
                      trailing: IconButton(
                          onPressed: () {}, icon: const Icon(Icons.chat)),
                      title: Text(chatRoom.senderName),
                      subtitle: Text(""),
                    );
                  },
                ).withExpanded(),
              ],
            ).withCustomPadding();
          } else {
            return const Center(
              child: Text('Welcome to the Patient feature!'),
            );
          }
        },
      ),
    );
  }
}
