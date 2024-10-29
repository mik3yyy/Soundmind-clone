import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:sound_mind/core/extensions/context_extensions.dart';
import 'package:sound_mind/core/extensions/widget_extensions.dart';
import 'package:sound_mind/core/services/injection_container.dart';
import 'package:sound_mind/core/widgets/custom_shimmer.dart';
import 'package:sound_mind/core/widgets/error_screen.dart';
import 'package:sound_mind/features/notification/presentation/widgets/notification_widget.dart';
import '../blocs/notification_bloc.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (context.read<NotificationBloc>().state is NotificationLoading ||
        context.read<NotificationBloc>().state is NotificationData) {
    } else {
      context.read<NotificationBloc>().add(GetNotificationsEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: context.colors.black,
        ),
        title: const Text('Notifications'),
        centerTitle: false,
      ),
      body: BlocConsumer<NotificationBloc, NotificationState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is NotificationData) {
            var notifications = state.notifications.reversed.toList();
            return Column(
              children: [
                ListView.separated(
                  separatorBuilder: (context, index) => Gap(10),
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    return NotificationWidget(
                      notification: notifications[index],
                    );
                  },
                ).withExpanded()
              ],
            );
          } else if (state is NotificationLoading) {
            return ComplexShimmer.listShimmer(itemCount: 6)
                .withExpanded()
                .withCustomPadding();
          } else if (state is NotificationFailure) {
            return CustomErrorScreen(onTap: () {
              context.read<NotificationBloc>().add(GetNotificationsEvent());
            });
          } else {
            return CircularProgressIndicator().toCenter();
          }
        },
      ),
    );
  }
}
