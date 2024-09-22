import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sound_mind/core/extensions/context_extensions.dart';
import 'package:sound_mind/core/extensions/widget_extensions.dart';
import 'package:sound_mind/core/gen/assets.gen.dart';
import 'package:sound_mind/core/routes/routes.dart';
import 'package:sound_mind/core/utils/string_extension.dart';
import 'package:sound_mind/core/widgets/custom_button.dart';
import 'package:sound_mind/features/appointment/data/models/doctor_detail.dart';
import 'package:sound_mind/features/appointment/presentation/blocs/doctor_details/doctor_details_cubit.dart';

class ViewDoctorPage extends StatefulWidget {
  const ViewDoctorPage({super.key, required this.id});
  final int id;
  @override
  State<ViewDoctorPage> createState() => _ViewDoctorPageState();
}

class _ViewDoctorPageState extends State<ViewDoctorPage> {
  @override
  void initState() {
    // TODO: implement initState
    print(widget.id);
    super.initState();
    context.read<DoctorDetailsCubit>().fetchDoctorDetails(widget.id);
  }

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('MMM d, yyyy');
    return formatter.format(date);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: Icon(
      //     Icons.chevron_left,
      //     color: context.colors.black,
      //     size: 30,
      //   ),
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         context.pop();
      //       },
      //       icon: Icon(
      //         Icons.message,
      //         color: context.colors.black,
      //       ),
      //     )
      //   ],
      // ),
      body: BlocBuilder<DoctorDetailsCubit, DoctorDetailsState>(
        builder: (context, state) {
          if (state is DoctorDetailsLoaded) {
            DoctorDetailModel detailModel = state.doctor;
            return Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(color: Color(0xFFF3EEFA)),
                    child: Column(
                      children: [
                        AppBar(
                          backgroundColor: Colors.transparent,
                          leadingWidth: 30,
                          leading: Icon(
                            Icons.chevron_left,
                            color: context.colors.black,
                            size: 30,
                          ),
                          actions: [
                            IconButton(
                              onPressed: () {
                                context.pop();
                              },
                              icon: Icon(
                                Icons.message,
                                color: context.colors.black,
                              ),
                            )
                          ],
                        ),
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
                        const Gap(5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "${detailModel.yoe}yrs",
                                  style: context.textTheme.displaySmall
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                const Text("Experience")
                              ],
                            ),
                            Container(
                              height: 50,
                              width: 2,
                              color: context.colors.white,
                            ),
                            Column(
                              children: [
                                Text(
                                  "0",
                                  style: context.textTheme.displaySmall
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                Text("Patients")
                              ],
                            ),
                            Container(
                              height: 50,
                              width: 2,
                              color: context.colors.white,
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Assets.application.assets.svgs.star
                                        .svg(height: 20, width: 20),
                                    Text(
                                      " 4.5",
                                      style: context.textTheme.displaySmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const Text("In reviews")
                              ],
                            ),
                          ],
                        ),
                        const Gap(10),
                        CustomButton(
                          color: context.secondaryColor,
                          label: "Message Therapist",
                          onPressed: () {},
                          titleWidget: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.message, color: context.primaryColor),
                              Text(
                                " Message Therapist",
                                style: context.textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: context.primaryColor),
                              )
                            ],
                          ),
                        ),
                        const Gap(10),
                      ],
                    ),
                  ),
                  Gap(20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pricing",
                        style: context.textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Gap(5),
                      Container(
                        height: 70,
                        width: context.screenWidth * .5,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: context.secondaryColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "₦${detailModel.consultationRate}",
                                  style: context.textTheme.displayMedium
                                      ?.copyWith(color: context.primaryColor),
                                ),
                                Text(
                                  "per session",
                                  style: context.textTheme.bodySmall
                                      ?.copyWith(color: context.primaryColor),
                                )
                              ],
                            ),
                            // Gap(20),
                            Container(
                              height: 40,
                              width: 1,
                              color: context.colors.white,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "2hrs",
                                  style: context.textTheme.displayMedium
                                      ?.copyWith(color: context.primaryColor),
                                ),
                                Text(
                                  "per session",
                                  style: context.textTheme.bodySmall
                                      ?.copyWith(color: context.primaryColor),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ).withCustomPadding(),
                  const Gap(20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "About",
                        style: context.textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Gap(5),
                      Text(detailModel.bio),
                    ],
                  ).withCustomPadding(),
                  const Gap(20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Specializations",
                        style: context.textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Gap(5),
                      Wrap(
                        spacing: 8.0, // Space between items
                        runSpacing: 4.0, // Space between rows
                        children: [
                          Chip(
                            label: Text(detailModel.areaOfSpecialization.name),
                            backgroundColor:
                                Colors.grey[200], // You can customize this
                          )
                        ],
                      ),
                    ],
                  ).withCustomPadding()
                ],
              ),
              bottomSheet: Container(
                height: 100,
                color: context.secondaryColor,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Earliest Availability",
                            style: context.textTheme.displaySmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Text(
                                  "${formatDate(detailModel.earliestAvailabiltyDate)} "),
                              CircleAvatar(
                                radius: 4,
                                backgroundColor: context.colors.black,
                              ),
                              Text(
                                  "  ${formatTimeRange(detailModel.earliestAvailabilitySchedule.startTime, detailModel.earliestAvailabilitySchedule.endTime)}"),
                            ],
                          )
                        ],
                      ),
                      CustomButton(
                        label: "Book Now",
                        onPressed: () {
                          context.goNamed(Routes.viewDayName);
                        },
                        width: context.screenWidth * .4,
                      )
                    ],
                  ),
                ),
              ),
            );
          }
          return Column(
            children: [],
          );
        },
      ),
    );
  }
}
