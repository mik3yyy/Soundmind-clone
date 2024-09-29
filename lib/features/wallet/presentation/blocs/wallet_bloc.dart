import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_mind/features/wallet/domain/usecases/get_user_wallet.dart';
import 'package:sound_mind/features/wallet/domain/usecases/get_user_transaction.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final GetUserWallet getUserWallet;

  WalletBloc({
    required this.getUserWallet,
  }) : super(WalletInitial()) {
    // Event handler for fetching wallet details
    on<FetchWalletDetailsEvent>(_onFetchWalletDetails);

    // Event handler for fetching wallet transactions
  }

  Future<void> _onFetchWalletDetails(
      FetchWalletDetailsEvent event, Emitter<WalletState> emit) async {
    emit(WalletLoading());

    final result = await getUserWallet.call();
    result.fold(
      (failure) => emit(WalletError(message: failure.message)),
      (wallet) => emit(WalletLoaded(wallet: wallet)),
    );
  }
}
