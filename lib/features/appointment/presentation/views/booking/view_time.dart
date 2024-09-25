import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sound_mind/core/extensions/context_extensions.dart';
import 'package:sound_mind/core/extensions/widget_extensions.dart';
import 'package:sound_mind/core/routes/routes.dart';
import 'package:sound_mind/core/services/injection_container.dart';
import 'package:sound_mind/core/utils/string_extension.dart';
import 'package:sound_mind/core/widgets/custom_button.dart';
import 'package:sound_mind/features/appointment/data/models/doctor_detail.dart';
import 'package:sound_mind/features/appointment/data/models/physician_schedule.dart';
import 'package:sound_mind/features/appointment/presentation/blocs/doctor_details/doctor_details_cubit.dart';
import 'package:sound_mind/features/appointment/presentation/blocs/physician_schedule/physician_schedule_cubit.dart';
import 'package:sound_mind/features/appointment/presentation/views/booking/view_summary.dart';

class SelectTimePage extends StatefulWidget {
  const SelectTimePage({super.key, required this.id, required this.day});
  final Object? id;
  final String day;
  @override
  State<SelectTimePage> createState() => _SelectTimePageState();
}

class _SelectTimePageState extends State<SelectTimePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // context
    //     .read<PhysicianScheduleCubit>()
    //     .fetchPhysicianSchedule(widget.id as int);
  }

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

  int currentIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book a session with"),
        centerTitle: false,
        leading: BackButton(
          color: context.colors.black,
        ),
      ),
      body: BlocConsumer<PhysicianScheduleCubit, PhysicianScheduleState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is PhysicianScheduleLoaded) {
            var physicianSchedule = state.schedules;

            List<PhysicianScheduleModel> availableDays = physicianSchedule
                .where((element) =>
                    element.isTaken == false &&
                    element.dayOfWeekTitle == widget.day)
                .toList();

            // List<String> days = [];

            // for (String day in availableDays) {
            //   if (days.contains(day)) {
            //   } else {
            //     days.add(day);
            //   }
            // }
            return BlocBuilder<DoctorDetailsCubit, DoctorDetailsState>(
              builder: (context, state) {
                if (state is DoctorDetailsLoaded) {
                  DoctorDetailModel detailModel = state.doctor;
                  return Scaffold(
                    body: Column(
                      children: [
                        const Gap(10),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 70,
                              backgroundColor: context.colors.white,
                              child: Image.network(
                                detailModel.profilePicture,
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                              ).withClip(60),
                            ),
                            Column(
                              children: [
                                AutoSizeText(
                                  "${detailModel.firstName} ${detailModel.lastName}"
                                      .toLowerCase()
                                      .capitalizeAllFirst,
                                  style: context.textTheme.bodyLarge
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                // Text(detailModel.)
                              ],
                            )
                          ],
                        ),
                        const Gap(15),
                        const Divider(),
                        const Gap(15),
                        Text(
                          "Therapist available days at the selected time ",
                          style: context.textTheme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Gap(10),
                        Expanded(
                          child: ListView.separated(
                            separatorBuilder: (context, index) => Gap(20),
                            itemCount: availableDays.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    currentIndex = index;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: currentIndex == index
                                        ? context.secondaryColor
                                        : context.colors.greyOutline,
                                    border: Border.all(
                                      color: currentIndex == index
                                          ? context.primaryColor
                                          : context.colors.greyOutline,
                                    ),
                                    borderRadius: BorderRadius.circular(38),
                                  ),
                                  padding: EdgeInsets.all(8),
                                  child: ListTile(
                                    leading: Transform.scale(
                                      scale:
                                          1.5, // Increase the scale to make the checkbox larger
                                      child: Checkbox(
                                        value: currentIndex == index,
                                        shape: const CircleBorder(),
                                        fillColor: WidgetStateProperty
                                            .resolveWith<Color>(
                                                (Set<WidgetState> states) {
                                          if (states
                                              .contains(WidgetState.selected)) {
                                            return context
                                                .primaryColor; // Color when the checkbox is checked
                                          }
                                          return Colors
                                              .grey; // Color when the checkbox is unchecked
                                        }),
                                        activeColor: Colors
                                            .grey, // Set the background color when checked
                                        onChanged: (value) {},
                                      ),
                                    ),
                                    titleAlignment:
                                        ListTileTitleAlignment.titleHeight,
                                    title: Text(formatTimeRange(
                                        availableDays[index].startTime,
                                        availableDays[index].endTime)),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ).withSafeArea().withCustomPadding(),
                    bottomNavigationBar: Container(
                      height: 150,
                      child: Center(
                        child: CustomButton(
                          label: "View Schedule Summary",
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewSummary(
                                        id: widget.id,
                                        schedule:
                                            availableDays[currentIndex])));
                            // context.goNamed(Routes.viewTimeName,
                            //     extra: widget.id,
                            //     queryParameters: {
                            //       'day': availableDays[currentIndex]
                            //     });
                          },
                          enable: currentIndex != -1,
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            );
          } else {
            return CircularProgressIndicator().toCenter();
          }
          // var physicianSchedule= state as
        },
      ),
    );
  }
}
