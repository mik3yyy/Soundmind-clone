import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_mind/core/extensions/context_extensions.dart';
import 'package:sound_mind/core/extensions/widget_extensions.dart';
import 'package:sound_mind/core/gen/assets.gen.dart';
import 'package:sound_mind/core/routes/routes.dart';
import 'package:sound_mind/core/utils/string_extension.dart';
import 'package:sound_mind/core/widgets/custom_text_field.dart';
import 'package:sound_mind/features/appointment/data/models/doctor.dart';
import 'package:sound_mind/features/appointment/presentation/blocs/doctor/doctor_cubit.dart';
import 'package:sound_mind/features/appointment/presentation/widgets/doctor_card.dart';
import 'package:sound_mind/features/appointment/presentation/widgets/sort_bottom_bar.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var state = context.read<DoctorCubit>().state;
    if (state is DoctorLoaded || state is DoctorLoading) {
    } else {
      context.read<DoctorCubit>().fetchDoctors(pageNumber: 1, pageSize: 20);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor:
      //     Color(0xFFF7F7F7), // context.colors.greyDecorDark.withOpacity(.2),
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Find Therapist',
          style: context.textTheme.displayMedium,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: BlocBuilder<DoctorCubit, DoctorState>(
            builder: (context, state) {
              if (state is DoctorLoaded) {
                return Column(
                  children: [
                    CustomTextField(
                      controller: controller,
                      radius: 30,
                      prefix: const Icon(Icons.search),
                      hintText: "Search",
                    ),
                    const Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (state.sort == null) ...[
                          Container(),
                        ] else ...[
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(36),
                                color: context.primaryColor),
                            child: Row(
                              children: [
                                Text(
                                  getTitle(state.sort!),
                                  style: context.textTheme.bodyMedium
                                      ?.copyWith(color: context.colors.white),
                                ),
                                // Icon(
                                //   getIconData(state.sort!),
                                //   color: context.colors.white,
                                //   size: 20,
                                // )
                              ],
                            ),
                          )
                        ],
                        Row(
                          children: [
                            CircleAvatar(
                              // radius: 25,
                              backgroundColor: context.colors.greyDecorDark,
                              child: Icon(
                                Icons.sort,
                                color: context.colors.black,
                              ),
                            ).withOnTap(() {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                useRootNavigator: true,
                                builder: (BuildContext context) {
                                  return const SortBottomBarWidget();
                                },
                              );
                            }),
                            Gap(10),
                            CircleAvatar(
                              // radius: 25,
                              backgroundColor: context.colors.greyDecorDark,
                              child: Icon(
                                state.display == Display.list
                                    ? Icons.grid_view
                                    : Icons.list,
                                color: context.colors.black,
                              ),
                            ).withOnTap(() {
                              // if(state.display==)
                              context.read<DoctorCubit>().chnageState(
                                  display: state.display == Display.list
                                      ? Display.grid
                                      : Display.list);
                            }),
                          ],
                        ),
                      ],
                    )
                  ],
                );
              } else {
                return Container();
              }
            },
          ).withPadding(const EdgeInsets.symmetric(horizontal: 20)),
        ),
      ),
      body: BlocBuilder<DoctorCubit, DoctorState>(
        builder: (context, state) {
          if (state is DoctorLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is DoctorError) {
            return Center(
              child: Text(state.message),
            );
          }
          if (state is DoctorLoaded) {
            List<DoctorModel> doctors = state.doctors;
            return Column(
              children: [
                const Gap(20),
                if (state.display == Display.list) ...[
                  ListView.separated(
                    separatorBuilder: (context, index) => const Gap(10),
                    itemCount: doctors.length,
                    itemBuilder: (context, index) {
                      DoctorModel doctor = doctors[index];
                      return ListTile(
                        onTap: () {
                          context.goNamed(Routes.view_docName,
                              extra: doctor.physicianId);
                        },
                        leading: Image.network(
                          doctor.profilePicture!,
                          width: 78,
                          height: 78,
                          fit: BoxFit.cover,
                        ).withClip(12),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              "${doctor.lastName} ${doctor.firstName}"
                                  .toLowerCase()
                                  .capitalizeAllFirst,
                              maxLines: 1,
                            ),
                            Row(
                              children: [
                                Assets.application.assets.svgs.star.svg(),
                                Text(
                                  " ${doctor.ratingAverage} ",
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "| ${doctor.yoe}yrs experience",
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ), //₦15,000
                              ],
                            ),
                            Text(
                              "₦${doctor.consultationRate}/ session",
                              style: context.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ), //₦15,000
                          ],
                        ),
                      );
                    },
                  ).withExpanded(),
                ] else ...[
                  GridView.builder(
                    padding: const EdgeInsets.all(10),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        mainAxisExtent: 230
                        // childAspectRatio:

                        //     0.7, // Adjust the aspect ratio to match the card layout
                        ),
                    itemCount: doctors.length,
                    itemBuilder: (context, index) {
                      return DoctorCard(doctor: doctors[index]).withOnTap(() {
                        context.goNamed(Routes.view_docName,
                            extra: doctors[index].physicianId);
                      });
                    },
                  ).withExpanded()
                ]
              ],
            );
          }

          return const CircularProgressIndicator();
          // return ;
        },
      ),
    );
  }
}
