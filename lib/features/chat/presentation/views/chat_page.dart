import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_mind/core/extensions/context_extensions.dart';
import 'package:sound_mind/core/extensions/widget_extensions.dart';
import 'package:sound_mind/core/gen/assets.gen.dart';
import 'package:sound_mind/core/routes/routes.dart';
import 'package:sound_mind/core/utils/image_util.dart';
import 'package:sound_mind/core/widgets/custom_shimmer.dart';
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
    var state = context.read<GetUserChatRoomsCubit>().state;

    if (state is! GetUserChatRoomsLoaded) {
      context.read<GetUserChatRoomsCubit>().fetchUserChatRooms();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        centerTitle: false,
      ),
      body: BlocBuilder<GetUserChatRoomsCubit, GetUserChatRoomsState>(
        builder: (context, state) {
          if (state is GetUserChatRoomsLoaded) {
            return Column(
              children: [
                ListView.builder(
                  itemCount: state.chatRooms.length,
                  itemBuilder: (context, index) {
                    var chatRoom = state.chatRooms[index];
                    return ListTile(
                      onTap: () {
                        context.goNamed(
                          Routes.chatRoomName,
                          extra: chatRoom,
                          pathParameters: {
                            'id': chatRoom.chatRoomID.toString()
                          },
                        );
                      },
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundColor: context.colors.greyDecor,
                        child: CachedNetworkImage(
                          imageUrl: chatRoom.senderProfilePhoto,
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) =>
                              CachedNetworkImage(
                                  imageUrl: ImageUtils.defaultImage),
                        ),
                      ).withClip(20),
                      trailing:
                          Assets.application.assets.svgs.therapistMessage.svg(),
                      title: Text(chatRoom.senderName),
                      subtitle: Text(
                        "Tap to open chat",
                        style: context.textTheme.bodySmall?.copyWith(
                            fontSize: 8, fontWeight: FontWeight.w700),
                      ),
                    );
                  },
                ).withExpanded(),
              ],
            ).withCustomPadding();
          } else if (state is GetUserChatRoomsLoading) {
            return ComplexShimmer.listShimmer(itemCount: 7)
                .withExpanded()
                .withCustomPadding();
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
