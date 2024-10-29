import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sound_mind/features/Authentication/domain/usecases/resend_otp.dart';

part 'resend_otp_state.dart';

class ResendOtpCubit extends Cubit<ResendOtpState> {
  final ResendVerificationOtp _resendVerificationOtp;

  ResendOtpCubit({required ResendVerificationOtp resendVerificationOtp})
      : _resendVerificationOtp = resendVerificationOtp,
        super(ResendOtpInitial());

  Future<void> resendOtp(String signupKey) async {
    emit(ResendOtpLoading());

    final params = ResendVerificationOtpParams(signupKey: signupKey);
    final result = await _resendVerificationOtp.call(params);

    result.fold(
      (failure) => emit(ResendOtpFailure(message: failure.message)),
      (_) => emit(ResendOtpSuccess()),
    );
  }
}
