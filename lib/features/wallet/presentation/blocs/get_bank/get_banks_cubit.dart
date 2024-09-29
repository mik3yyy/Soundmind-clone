import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sound_mind/features/wallet/domain/usecases/get_banks.dart';

part 'get_banks_state.dart';

class GetBanksCubit extends Cubit<GetBanksState> {
  final GetBanks getBanks;

  GetBanksCubit({required this.getBanks}) : super(GetBanksInitial());

  Future<void> fetchBanks() async {
    emit(GetBanksLoading());

    final result = await getBanks.call();
    result.fold(
      (failure) => emit(GetBanksError(message: failure.message)),
      (banks) => emit(GetBanksLoaded(banks: banks)),
    );
  }
}
