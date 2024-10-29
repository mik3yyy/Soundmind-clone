import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_mind/core/extensions/context_extensions.dart';
import 'package:sound_mind/core/utils/date_formater.dart';
import 'package:sound_mind/core/utils/image_util.dart';
import 'package:sound_mind/core/widgets/custom_button.dart';
import 'package:sound_mind/core/widgets/error_screen.dart';
import 'package:sound_mind/features/appointment/data/models/appointment.dart';
import 'package:sound_mind/features/appointment/presentation/blocs/get_accepted_appointments/get_accepted_appointments_cubit.dart';
import 'package:sound_mind/features/appointment/presentation/blocs/get_pending_appointments/get_pending_appointments_cubit.dart';
import 'package:sound_mind/features/appointment/presentation/blocs/get_rejected_appointments/get_rejected_appointments_cubit.dart';
import 'package:sound_mind/features/main/presentation/views/home_screen/home_screen.dart';

class ViewBookingScreen extends StatefulWidget {
  const ViewBookingScreen({super.key});

  @override
  State<ViewBookingScreen> createState() => _ViewBookingScreenState();
}

class _ViewBookingScreenState extends State<ViewBookingScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    if (context.read<AcceptedAppointmentsCubit>().state
            is! AcceptedAppointmentsLoaded &&
        context.read<AcceptedAppointmentsCubit>().state
            is! AcceptedAppointmentsLoading) {
      context.read<AcceptedAppointmentsCubit>().fetchAcceptedAppointments();
    }
    if (context.read<RejectedAppointmentsCubit>().state
            is! RejectedAppointmentsLoaded &&
        context.read<RejectedAppointmentsCubit>().state
            is! RejectedAppointmentsLoading) {
      context.read<RejectedAppointmentsCubit>().fetchRejectedAppointments();
    }
    if (context.read<PendingAppointmentsCubit>().state
            is! PendingAppointmentsLoaded &&
        context.read<PendingAppointmentsCubit>().state
            is! PendingAppointmentsLoading) {
      context.read<PendingAppointmentsCubit>().fetchPendingAppointments();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: context.colors.black,
        ),
        title: const Text('Bookings'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "Pending"),
            Tab(text: "Accepted"),
            Tab(text: "Rejected"),
          ],
          indicator: BoxDecoration(
            color:
                context.primaryColor, // Background color for the selected tab
            borderRadius: BorderRadius.circular(20), // Rounded corners
          ),
          labelColor: Colors.white, // Text color for the selected tab
          unselectedLabelColor: Colors.grey, // Text color for unselected tabs
          // labelPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          indicatorSize:
              TabBarIndicatorSize.tab, // Make indicator cover the whole tab
          indicatorPadding:
              EdgeInsets.zero, // Ensures indicator has no extra padding

          padding: EdgeInsets.symmetric(horizontal: 20),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPendingAppointments(),
          _buildAcceptedAppointments(),
          _buildRejectedAppointments(),
        ],
      ),
    );
  }

  Widget _buildPendingAppointments() {
    return BlocBuilder<PendingAppointmentsCubit, PendingAppointmentsState>(
      builder: (context, state) {
        if (state is PendingAppointmentsLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is PendingAppointmentsLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              context
                  .read<PendingAppointmentsCubit>()
                  .fetchPendingAppointments();
            },
            child: ListView.builder(
              itemCount: state.appointments.length,
              itemBuilder: (context, index) {
                final appoitments = state.appointments[index];
                return _buildAppointmentCard(
                  appointment: appoitments,
                  status: 'Approval Pending',
                  onTap: () {
                    // Handle follow-up request action here
                  },
                );
              },
            ),
          );
        } else if (state is PendingAppointmentsError) {
          return CustomErrorScreen(
            onTap: () {
              context
                  .read<PendingAppointmentsCubit>()
                  .fetchPendingAppointments();
            },
            message: state.message,
          );
        }
        return Container();
      },
    );
  }

  Widget _buildAcceptedAppointments() {
    return BlocBuilder<AcceptedAppointmentsCubit, AcceptedAppointmentsState>(
      builder: (context, state) {
        if (state is AcceptedAppointmentsLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is AcceptedAppointmentsLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              await context
                  .read<AcceptedAppointmentsCubit>()
                  .fetchAcceptedAppointments();
            },
            child: ListView.builder(
              itemCount: state.appointments.length,
              itemBuilder: (context, index) {
                final appoitments = state.appointments[index];
                return _buildAppointmentCard(
                  appointment: appoitments,
                  status: 'Approved',
                  onTap: () {
                    // Handle view details action here
                  },
                );
              },
            ),
          );
        } else if (state is AcceptedAppointmentsError) {
          return CustomErrorScreen(
            onTap: () {
              context
                  .read<AcceptedAppointmentsCubit>()
                  .fetchAcceptedAppointments();
            },
            message: state.message,
          );
        }
        return Container();
      },
    );
  }

  Widget _buildRejectedAppointments() {
    return BlocBuilder<RejectedAppointmentsCubit, RejectedAppointmentsState>(
      builder: (context, state) {
        if (state is RejectedAppointmentsLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is RejectedAppointmentsLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              context
                  .read<RejectedAppointmentsCubit>()
                  .fetchRejectedAppointments();
            },
            child: ListView.builder(
              itemCount: state.appointments.length,
              itemBuilder: (context, index) {
                final appoitments = state.appointments[index];
                return _buildAppointmentCard(
                  appointment: appoitments,
                  status: 'Rejected',
                  onTap: () {
                    // Handle request review action here
                  },
                );
              },
            ),
          );
        } else if (state is RejectedAppointmentsError) {
          return CustomErrorScreen(
            onTap: () {
              context
                  .read<RejectedAppointmentsCubit>()
                  .fetchRejectedAppointments();
            },
            message: state.message,
          );
        }
        return Container();
      },
    );
  }

  Widget _buildAppointmentCard({
    required AppointmentDto appointment,
    required VoidCallback onTap,
    required String status,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                      imageUrl:
                          appointment.profilePicture ?? ImageUtils.profile),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(appointment.therapistName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    // Text(appointment.areaOfSpecialization ?? "",
                    //     style: TextStyle(color: Colors.grey[600])),
                    Text("Day: ${appointment.schedule.dayOfWeekTitle}"),
                    Text(
                        "Time: ${DateFormater.formatTimeRange(appointment.schedule.startTime, appointment.schedule.endTime)}"),
                    Text(
                      status,
                    ),
                  ],
                ),
              ],
            ),
            // SizedBox(height: 16),
            // CustomButton(label: "", onPressed: onPressed)
            // ElevatedButton.icon(
            //   onPressed: onTap,
            //   icon: Icon(Icons.notifications, color: Colors.purple),
            //   label: Text(actionText, style: TextStyle(color: Colors.purple)),
            //   style: ElevatedButton.styleFrom(
            //     primary: Colors.purple.withOpacity(0.1),
            //     shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(20)),
            //     elevation: 0,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
