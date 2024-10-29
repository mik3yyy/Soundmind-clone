part of 'resend_otp_cubit.dart';

abstract class ResendOtpState extends Equatable {
  @override
  List<Object> get props => [];
}

class ResendOtpInitial extends ResendOtpState {}

class ResendOtpLoading extends ResendOtpState {}

class ResendOtpSuccess extends ResendOtpState {}

class ResendOtpFailure extends ResendOtpState {
  final String message;

  ResendOtpFailure({required this.message});

  @override
  List<Object> get props => [message];
}
