import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sound_mind/features/wallet/domain/usecases/confirm_wallet_top_up.dart';
import 'package:sound_mind/features/wallet/domain/usecases/initiate_wallet_top_up.dart';

part 'topup_wallet_state.dart';

class TopUpCubit extends Cubit<TopUpState> {
  final InitiateWalletTopUp initiateWalletTopUp;
  final ConfirmWalletTopUp confirmWalletTopUp;

  TopUpCubit({
    required this.initiateWalletTopUp,
    required this.confirmWalletTopUp,
  }) : super(TopUpInitial());

  Future<void> initiateTopUp(double amount) async {
    emit(TopUpLoading());

    final result = await initiateWalletTopUp
        .call(InitiateWalletTopUpParams(amount: amount));
    result.fold(
      (failure) => emit(TopUpError(message: failure.message)),
      (topUpDetails) => emit(TopUpInitiated(topUpDetails: topUpDetails)),
    );
  }

  Future<void> confirmTopUp(
      String transactionReference, String flutterwaveTransactionID) async {
    emit(TopUpLoading());

    final result = await confirmWalletTopUp.call(
      ConfirmWalletTopUpParams(
        transactionReference: transactionReference,
        flutterwaveTransactionID: flutterwaveTransactionID,
      ),
    );
    result.fold(
      (failure) => emit(TopUpError(message: failure.message)),
      (_) => emit(TopUpConfirmed()),
    );
  }
}
