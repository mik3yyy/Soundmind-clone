import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sound_mind/core/extensions/context_extensions.dart';
import 'package:sound_mind/core/extensions/widget_extensions.dart';
import 'package:sound_mind/core/utils/date_formater.dart';
import 'package:sound_mind/features/notification/data/models/notification_model.dart';

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({super.key, required this.notification});
  final NotificationModel notification;
  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  String getTitle() {
    switch (widget.notification.type) {
      case 1:
        return "Booking request Pending";
      case 2:
        return "Booking request approved";
      case 3:
        return "Booking request denied";
      case 4:
        return "Message from a Therapist";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: 166,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(
                Icons.safety_check,
              ),
              title: Text(
                getTitle(),
                style: context.textTheme.displaySmall,
              ),
              trailing: Text(
                DateFormater.formatDate(widget.notification.timeCreated),
              ),
              subtitle: Text(widget.notification.message),
            )
          ],
        ));
  }
}
