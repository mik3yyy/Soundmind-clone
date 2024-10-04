import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_mind/core/extensions/context_extensions.dart';
import 'package:sound_mind/core/extensions/widget_extensions.dart';
import 'package:sound_mind/core/widgets/custom_button.dart';
import 'package:sound_mind/features/appointment/presentation/blocs/doctor/doctor_cubit.dart';
import 'package:sound_mind/features/main/presentation/views/home_screen/home_screen.dart';
import 'package:sound_mind/features/notification/presentation/views/notification_page.dart';

class SortBottomBarWidget extends StatefulWidget {
  const SortBottomBarWidget({super.key});

  @override
  State<SortBottomBarWidget> createState() => _SortBottomBarWidgetState();
}

class _SortBottomBarWidgetState extends State<SortBottomBarWidget> {
  Sort? sort;
  List<Sort> sorts = [
    Sort.a_z,
    Sort.z_a,
    Sort.Rl_h,
    Sort.Rh_l,
    Sort.Ph_l,
    Sort.Pl_h,
    Sort.most_experienced
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sort = (context.read<DoctorCubit>().state as DoctorLoaded).sort;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 800,
      color: context.colors.white,
      child: Column(
        children: <Widget>[
          AppBar(
            centerTitle: false,
            leadingWidth: 0,
            backgroundColor: context.colors.white,
            actions: [
              Icon(
                Icons.cancel_outlined,
                color: context.colors.black,
              ),
              const Gap(20),
            ],
            title: Text(
              "Sort by",
              style: context.textTheme.displaySmall,
            ),
          ),
          BlocBuilder<DoctorCubit, DoctorState>(
            builder: (context, state) {
              return ListView.builder(
                itemCount: 7,
                itemBuilder: (context, index) {
                  return ListTile(
                    trailing: Checkbox(
                      activeColor: context.primaryColor,
                      value: sort == sorts[index],
                      onChanged: (value) {
                        setState(() {
                          sort = sorts[index];
                        });
                      },
                    ),
                    textColor: sort == sorts[index]
                        ? context.primaryColor
                        : context.colors.black,
                    leading: Icon(
                      getIconData(sorts[index]),
                      color: sort == sorts[index]
                          ? context.primaryColor
                          : context.colors.black,
                    ),
                    title: Text(getTitle(sorts[index])),
                    onTap: () {
                      Navigator.pop(context); // Closes the modal
                    },
                  );
                },
              );
            },
          ).withExpanded(),
          CustomButton(
            label: "Save",
            onPressed: () {
              context.read<DoctorCubit>().chnageState(sort: sort);
              context.pop();
            },
          ),
          Gap(20),
        ],
      ),
    );
  }
}

String getTitle(Sort sort) {
  switch (sort) {
    case Sort.a_z:
      return 'A - Z';
    case Sort.z_a:
      return 'Z - A';
    case Sort.Rl_h:
      return 'Rating (low to High)';
    case Sort.Rh_l:
      return 'Rating (High to low)';
    case Sort.Ph_l:
      return 'Price (High to low)';
    case Sort.Pl_h:
      return 'Price (low to high)';
    case Sort.most_experienced:
      return 'Most Experienced';
    default:
      return 'Unknown';
  }
}

IconData getIconData(Sort sort) {
  switch (sort) {
    case Sort.a_z:
      return Icons.sort_by_alpha; // Icon for A-Z
    case Sort.z_a:
      return Icons
          .sort_by_alpha; // Icon for Z-A (you can rotate this to simulate reverse sorting if needed)
    case Sort.Rl_h:
      return Icons.star_border; // Icon for Rating (low to High)
    case Sort.Rh_l:
      return Icons.star; // Icon for Rating (High to low)
    case Sort.Ph_l:
      return Icons.arrow_downward; // Icon for Price (High to low)
    case Sort.Pl_h:
      return Icons.arrow_upward; // Icon for Price (Low to high)
    case Sort.most_experienced:
      return Icons.access_time; // Icon for Most Available
    default:
      return Icons.help_outline; // Default unknown icon
  }
}
