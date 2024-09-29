import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sound_mind/features/wallet/domain/usecases/get_user_transaction.dart';

part 'get_bank_transactions_state.dart';

class GetBankTransactionsCubit extends Cubit<GetBankTransactionsState> {
  final GetUserWalletTransactions getUserWalletTransactions;

  GetBankTransactionsCubit({required this.getUserWalletTransactions})
      : super(GetBankTransactionsInitial());

  Future<void> fetchBankTransactions() async {
    emit(GetBankTransactionsLoading());

    final result = await getUserWalletTransactions.call();
    result.fold(
      (failure) {
        if (failure.message == 'No Transactions Fetched') {
          emit(GetBankTransactionsEmpty(message: failure.message));
        } else {
          emit(GetBankTransactionsError(message: failure.message));
        }
      },
      (transactions) =>
          emit(GetBankTransactionsLoaded(transactions: transactions)),
    );
  }
}
