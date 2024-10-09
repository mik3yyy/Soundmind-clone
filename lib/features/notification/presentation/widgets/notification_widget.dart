import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_mind/core/extensions/context_extensions.dart';
import 'package:sound_mind/core/routes/routes.dart';
import 'package:sound_mind/core/utils/date_formater.dart';
import 'package:sound_mind/core/widgets/custom_button.dart';
import 'package:sound_mind/features/appointment/data/models/MakePaymentBookingReq.dart';
import 'package:sound_mind/features/appointment/domain/usecases/make_appointment_payment.dart';
import 'package:sound_mind/features/appointment/presentation/blocs/payment/payment_cubit.dart';
import 'package:sound_mind/features/appointment/presentation/widgets/successful_dialog.dart';
import 'package:sound_mind/features/notification/data/models/notification_model.dart';
import 'package:sound_mind/features/notification/presentation/widgets/loading.dart';

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
        margin: EdgeInsets.symmetric(horizontal: 20),
        width: context.screenWidth * .8,
        // height: 166,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: context.colors.white,
        ),
        padding: EdgeInsets.all(10),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.end,
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
              subtitle: Column(
                children: [
                  Text(widget.notification.message),
                ],
              ),
            ),
            if (widget.notification.type == 3) ...[
              CustomButton(
                width: context.screenWidth * .6,
                color: context.secondaryColor,
                textColor: context.primaryColor,
                label: "View other Therapist",
                onPressed: () {
                  context.goNamed(Routes.findADocName);
                },
              ),
            ],
            if (widget.notification.type == 2) ...[
              BlocListener<PaymentCubit, PaymentState>(
                listener: (context, state) {
                  // TODO: implement listener
                  if (state is PaymentLoading) {
                    showDialog(
                      context: context,
                      builder: (context) => const LoadingScreen(),
                    );
                  }
                  if (state is PaymentError) {
                    context.pop();
                    context.showSnackBar(state.message);
                  }
                  if (state is PaymentSuccess) {
                    context.pop();

                    showDialog(
                      context: context,
                      builder: (context) => SuccessfulDialogWidget(
                        message: "Payment successful",
                        onTap: () {
                          context.pop();
                        },
                      ),
                    );
                  }
                },
                child: CustomButton(
                  width: context.screenWidth * .6,
                  color: context.secondaryColor,
                  textColor: context.primaryColor,
                  label: "Pay to complete booking",
                  onPressed: () {
                    context.read<PaymentCubit>().makePaymentEvent(
                        MakePaymentForAppointmentParams(
                            request: MakePaymentForAppointmentRequest(
                                bookingID: widget.notification.bookingId)));
                  },
                ),
              ),
            ]
          ],
        ));
  }
}
