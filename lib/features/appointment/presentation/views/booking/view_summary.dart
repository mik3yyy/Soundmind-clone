import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:sound_mind/core/extensions/context_extensions.dart';
import 'package:sound_mind/core/extensions/widget_extensions.dart';
import 'package:sound_mind/core/utils/string_extension.dart';
import 'package:sound_mind/core/widgets/custom_button.dart';
import 'package:sound_mind/features/appointment/data/models/CreateBookingReq.dart';
import 'package:sound_mind/features/appointment/data/models/physician_schedule.dart';
import 'package:sound_mind/features/appointment/domain/usecases/create_booking.dart';
import 'package:sound_mind/features/appointment/presentation/blocs/booking/booking_cubit.dart';
import 'package:sound_mind/features/appointment/presentation/blocs/doctor_details/doctor_details_cubit.dart';
import 'package:sound_mind/features/appointment/presentation/widgets/succesful_widget.dart';

class ViewSummary extends StatefulWidget {
  const ViewSummary({super.key, required this.id, required this.schedule});
  final Object? id;
  final PhysicianScheduleModel schedule;
  @override
  State<ViewSummary> createState() => _ViewSummaryState();
}

class _ViewSummaryState extends State<ViewSummary> {
  String formatTimeRange(String startTimeStr, String endTimeStr) {
    // Parse the time strings into DateTime objects
    DateTime startTime = DateFormat("HH:mm:ss").parse(startTimeStr);
    DateTime endTime = DateFormat("HH:mm:ss").parse(endTimeStr);

    // Format them into the desired 12-hour format with lowercase AM/PM
    final DateFormat timeFormatter = DateFormat('h:mma');
    String formattedStartTime = timeFormatter.format(startTime).toLowerCase();
    String formattedEndTime = timeFormatter.format(endTime).toLowerCase();

    return '$formattedStartTime - $formattedEndTime';
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateBookingCubit, CreateBookingState>(
      listener: (context, state) {
        if (state is CreateBookingSuccess) {
          showDialog(
              useSafeArea: false,
              context: context,
              builder: (context) => BookingSuccessfulWidget());
        }
        if (state is CreateBookingError) {
          context.showSnackBar(state.message);
        }
      },
      child: Scaffold(
        body: BlocBuilder<DoctorDetailsCubit, DoctorDetailsState>(
          builder: (context, state) {
            if (state is DoctorDetailsLoaded) {
              var details = state.doctor;
              return Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [context.secondaryColor, context.colors.white],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight)),
                child: Column(
                  children: [
                    AppBar(
                      backgroundColor: Colors.transparent,
                      title: const Text("Session Summary"),
                      centerTitle: false,
                      leading: BackButton(
                        color: context.colors.black,
                      ),
                    ),
                    Gap(30),
                    Text(
                      "You are almost done booking a session with",
                      style: context.textTheme.displayMedium,
                      textAlign: TextAlign.center,
                    ).withCustomPadding(),
                    Gap(20),
                    CircleAvatar(
                      radius: 70,
                      backgroundColor: context.colors.white,
                      child: Image.network(
                        details.profilePicture,
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ).withClip(60),
                    ),
                    Gap(20),
                    AutoSizeText(
                      "${details.firstName} ${details.lastName}"
                          .toLowerCase()
                          .capitalizeAllFirst,
                      style: context.textTheme.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Gap(30),
                    Container(
                      width: context.screenWidth * .9,
                      height: 72,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                            formatTimeRange(widget.schedule.startTime,
                                widget.schedule.endTime),
                            style: context.textTheme.displaySmall,
                          )
                        ],
                      ),
                    ),
                    Gap(10),
                    Container(
                      width: context.screenWidth * .9,
                      height: 72,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                          Text("Day"),
                          Text(
                            widget.schedule.dayOfWeekTitle,
                            style: context.textTheme.displaySmall,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else {
              return CircularProgressIndicator().toCenter();
            }
          },
        ),
        backgroundColor: context.secondaryColor,
        bottomNavigationBar: Container(
          color: Colors.transparent,
          height: 150,
          child: Center(
            child: BlocBuilder<CreateBookingCubit, CreateBookingState>(
              builder: (context, state) {
                return CustomButton(
                  label: "Send Booking Request",
                  notifier: ValueNotifier(state is CreateBookingLoading),
                  onPressed: () {
                    context.read<CreateBookingCubit>().createBookingEvent(
                        CreateBookingParams(
                            request: CreateBookingRequest(
                                physicianID: widget.id as int,
                                scheduleID: widget.schedule.id)));
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
