import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_mind/core/extensions/context_extensions.dart';
import 'package:sound_mind/core/extensions/widget_extensions.dart';
import 'package:sound_mind/core/routes/routes.dart';
import 'package:sound_mind/core/services/injection_container.dart';
import 'package:sound_mind/core/utils/string_extension.dart';
import 'package:sound_mind/core/widgets/custom_button.dart';
import 'package:sound_mind/core/widgets/custom_shimmer.dart';
import 'package:sound_mind/core/widgets/error_screen.dart';
import 'package:sound_mind/features/appointment/data/models/doctor_detail.dart';
import 'package:sound_mind/features/appointment/presentation/blocs/doctor_details/doctor_details_cubit.dart';
import 'package:sound_mind/features/appointment/presentation/blocs/physician_schedule/physician_schedule_cubit.dart';

class SelectDayPage extends StatefulWidget {
  const SelectDayPage({super.key, required this.id});
  final Object? id;
  @override
  State<SelectDayPage> createState() => _SelectDayPageState();
}

class _SelectDayPageState extends State<SelectDayPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context
        .read<PhysicianScheduleCubit>()
        .fetchPhysicianSchedule(widget.id as int);
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

            List<String> availableDays = physicianSchedule
                .where((element) => element.isTaken == false)
                .map((e) => e.dayOfWeekTitle)
                .toList();

            List<String> days = [];

            for (String day in availableDays) {
              if (days.contains(day)) {
              } else {
                days.add(day);
              }
            }
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
                              radius: 50,
                              backgroundColor: context.colors.white,
                              child: Image.network(
                                detailModel.profilePicture,
                                height: 90,
                                width: 90,
                                fit: BoxFit.cover,
                              ).withClip(60),
                            ),
                            Gap(20),
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
                            itemCount: days.length,
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
                                    title: Text(days[index]),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ).withSafeArea().withCustomPadding(),
                    bottomNavigationBar: SizedBox(
                      height: 100,
                      child: Center(
                        child: CustomButton(
                          label: "Proceed to select time",
                          onPressed: () {
                            context.goNamed(Routes.viewTimeName,
                                extra: widget.id,
                                queryParameters: {
                                  'day': availableDays[currentIndex]
                                });
                          },
                          enable: currentIndex != -1,
                        ),
                      ),
                    ),
                  );
                } else {
                  return const CircularProgressIndicator().toCenter();
                }
              },
            );
          } else if (state is PhysicianScheduleError) {
            return CustomErrorScreen(
              onTap: () {
                context
                    .read<PhysicianScheduleCubit>()
                    .fetchPhysicianSchedule(widget.id as int);
              },
              message: state.message,
            );
          } else {
            return Scaffold(
              body: ComplexShimmer.bookingScreenShimmer(context),
            );
          }

          // var physicianSchedule= state as
        },
      ),
    );
  }
}
