import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/usecases/get_main_data.dart';

part 'main_event.dart';
part 'main_state.dart';


class MainBloc extends Bloc<MainEvent, MainState> {
  final GetMainData getMainData;

  MainBloc({
  required this.getMainData
  }) : super(MainInitial());

}
