import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sound_mind/core/extensions/context_extensions.dart';
import 'package:sound_mind/core/extensions/widget_extensions.dart';
import 'package:sound_mind/core/utils/date_formater.dart';
import 'package:sound_mind/features/appointment/data/models/appointment.dart';
import 'package:clipboard/clipboard.dart';

class ViewSessionScreen extends StatefulWidget {
  const ViewSessionScreen({super.key, required this.appointment});
  final AppointmentDto appointment;
  @override
  State<ViewSessionScreen> createState() => _ViewSessionScreenState();
}

class _ViewSessionScreenState extends State<ViewSessionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [context.secondaryColor, context.colors.white],
            end: Alignment.topRight,
            begin: Alignment.bottomLeft,
          ),
        ),
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              leading: BackButton(
                color: context.colors.black,
              ),
              title: const Text("Session"),
              centerTitle: false,
            ),
            CircleAvatar(
              radius: 35,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: widget.appointment.profilePicture ?? "",
                  width: 70,
                  height: 70,
                ),
              ),
            ),
            Text(widget.appointment.therapistName),
            Text("${widget.appointment.areaOfSpecialization}"),
            const Gap(20),
            Container(
              width: context.screenWidth * .9,
              height: 72,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  color: context.secondaryColor.withOpacity(.5),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: context.colors.white,
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Time"),
                  Text(
                    DateFormater.formatTimeRange(
                        widget.appointment.schedule.startTime,
                        widget.appointment.schedule.endTime),
                    style: context.textTheme.displaySmall,
                  )
                ],
              ),
            ),
            const Gap(20),
            Container(
              width: context.screenWidth * .9,
              height: 72,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  color: context.secondaryColor.withOpacity(.5),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: context.colors.white,
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Date"),
                  Text(
                    DateFormater.formatDateTime(
                        widget.appointment.booking.date),
                    style: context.textTheme.displaySmall,
                  )
                ],
              ),
            ),
            const Gap(20),
            Container(
              width: context.screenWidth * .9,
              // height: 90,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  color: context.secondaryColor.withOpacity(.5),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: context.colors.white,
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Video Call link"),
                  AutoSizeText(
                    "https://meet.google.com/?authuser=${widget.appointment.booking.physicianId}",
                    maxLines: 1,
                    maxFontSize: 16,
                    minFontSize: 9,
                    style: context.textTheme.displaySmall,
                  ),
                  Gap(10),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: context.secondaryColor,
                      borderRadius: BorderRadius.circular(36),
                    ),
                    child: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          Icon(
                            Icons.copy,
                            color: context.primaryColor,
                            size: 20,
                          ),
                          Text(
                            "Copy Link",
                            style: context.textTheme.bodyMedium
                                ?.copyWith(color: context.primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ).withOnTap(() {
                    FlutterClipboard.copy(
                      "https://meet.google.com/?authuser=${widget.appointment.booking.physicianId}",
                      // ignore: avoid_print
                    ).then((value) => context.showSnackBar("Copied"));
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
