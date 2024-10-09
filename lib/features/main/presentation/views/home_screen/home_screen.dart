import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_mind/core/extensions/context_extensions.dart';
import 'package:sound_mind/core/extensions/widget_extensions.dart';
import 'package:sound_mind/core/gen/assets.gen.dart';
import 'package:sound_mind/core/routes/routes.dart';
import 'package:sound_mind/core/utils/date_formater.dart';
import 'package:sound_mind/features/Authentication/presentation/blocs/Authentication_bloc.dart';
import 'package:sound_mind/features/appointment/presentation/blocs/upcoming_appointment/upcoming_appointment_cubit.dart';
import 'package:sound_mind/features/wallet/presentation/views/withdraw_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var state = context.read<UpcomingAppointmentCubit>().state;
    if (state is! UpcomingAppointmentsLoaded) {
      context.read<UpcomingAppointmentCubit>().fetchUpcomingAppointments();
    }
  }

//disclaimer, imfo
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              var user = (state as UserAccount).user;
              return Container(
                height: context.screenHeight * .3,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      stops: [.9, 1],
                      colors: [context.secondaryColor, context.colors.white],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topLeft),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBar(
                      backgroundColor: Colors.transparent,
                      // leading: CircleAvatar(
                      //   radius: 30,
                      //   child: ClipRRect(
                      //     borderRadius: BorderRadius.circular(30),
                      //   ),
                      // ),
                      centerTitle: false,
                      leadingWidth: 0,
                      title: Text("Good morning, ${user.firstName}"),
                      actions: [
                        IconButton(
                          onPressed: () {
                            context.goNamed(Routes.notificationName);
                          },
                          icon: Icon(
                            Icons.notifications_outlined,
                            color: context.colors.black,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            context.goNamed(Routes.settingsName);
                          },
                          icon: Icon(
                            Icons.settings_outlined,
                            color: context.colors.black,
                          ),
                        ),
                      ],
                    ),
                    Gap(20),
                    Text(
                      "How are you feeling today?",
                      style: context.textTheme.displayMedium,
                    ),
                    Wrap(
                      spacing: 5,
                      children: [
                        "Happy",
                        "Sad",
                        "Energetic",
                        "Just a little down",
                        "Anxious",
                        "Relaxed"
                      ]
                          .map(
                            (e) => Chip(
                              backgroundColor: context.tertiaryColor,
                              label: Text(e),
                            ),
                          )
                          .toList(),
                    )
                  ],
                ).withCustomPadding(),
              );
            },
          ),
          const Gap(20),
          BlocBuilder<UpcomingAppointmentCubit, UpcomingAppointmentState>(
            builder: (context, state) {
              if (state is UpcomingAppointmentsLoaded) {
                var doc = state.upcomingAppointments;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Upcoming session",
                      style: context.textTheme.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                    Gap(10),
                    Container(
                      padding: EdgeInsets.all(10),
                      width: context.screenWidth * .9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: context.primaryColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.network(
                                doc.profilePicture!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ).withClip(4),
                              Gap(20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    doc.therapistName,
                                    style: context.textTheme.displayMedium
                                        ?.copyWith(
                                      color: context.colors.white,
                                    ),
                                  ),
                                  Text(
                                    doc.areaOfSpecialization ?? "",
                                    style: context.textTheme.bodyMedium
                                        ?.copyWith(color: context.colors.white),
                                  ),
                                  Text(
                                    "Google Meet",
                                    style: context.textTheme.displaySmall
                                        ?.copyWith(
                                      color: context.colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Gap(10),
                          Container(
                            height: 40,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(28),
                              color: Colors.purple[900]?.withOpacity(.5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.timer,
                                      color: context.colors.white,
                                    ),
                                    const Gap(5),
                                    Text(
                                      DateFormater.formatTimeRange(
                                          doc.schedule.startTime,
                                          doc.schedule.endTime),
                                      style: context.textTheme.bodyMedium
                                          ?.copyWith(
                                        color: context.colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_month,
                                      color: context.colors.white,
                                    ),
                                    const Gap(5),
                                    Text(
                                      DateFormater.formatDateTime(
                                        doc.booking.date,
                                      ),
                                      style: context.textTheme.bodyMedium
                                          ?.copyWith(
                                        color: context.colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ).withCustomPadding();
              } else {
                return Container();
              }
            },
          ),
          const Gap(20),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 190,
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: context.colors.white,
                    ),
                    padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Find Therapist",
                          style: context.textTheme.displaySmall,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Assets.application.assets.svgs.findTherapistSc
                                .svg(),
                            CircleAvatar(
                              backgroundColor: context.secondaryColor,
                              radius: 20,
                              child: Icon(
                                Icons.arrow_forward,
                                color: context.primaryColor,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ).withOnTap(() {
                    context.goNamed(Routes.findADocName);
                  }),
                  Container(
                    width: 190,
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: context.colors.white,
                    ),
                    padding: const EdgeInsets.only(
                        top: 10, left: 10, right: 10, bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Resources to boost your\nfeelings",
                          style: context.textTheme.displaySmall
                              ?.copyWith(height: 1.2),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundColor: context.secondaryColor,
                              radius: 20,
                              child: Icon(
                                Icons.arrow_forward,
                                color: context.primaryColor,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ).withOnTap(() {
                    context.goNamed(Routes.blogName);
                  }),
                ],
              ),
            ],
          ).withCustomPadding()
        ],
      ),
      backgroundColor: context.tertiaryColor,
    );
  }
}
