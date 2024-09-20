import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_mind/features/Wallet/domain/usecases/get_user_wallet.dart';
import 'package:sound_mind/features/wallet/domain/usecases/get_user_transaction.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final GetUserWallet getUserWallet;
  final GetUserWalletTransactions getUserWalletTransactions;

  WalletBloc({
    required this.getUserWallet,
    required this.getUserWalletTransactions,
  }) : super(WalletInitial()) {
    // Event handler for fetching wallet details
    on<FetchWalletDetailsEvent>(_onFetchWalletDetails);

    // Event handler for fetching wallet transactions
    on<FetchWalletTransactionsEvent>(_onFetchWalletTransactions);
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

  Future<void> _onFetchWalletTransactions(
      FetchWalletTransactionsEvent event, Emitter<WalletState> emit) async {
    emit(WalletLoading());

    final result = await getUserWalletTransactions.call();
    result.fold(
      (failure) => emit(WalletError(message: failure.message)),
      (transactions) =>
          emit(WalletTransactionsLoaded(transactions: transactions)),
    );
  }
}
