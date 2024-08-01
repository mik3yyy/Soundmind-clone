import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'Security_event.dart';
part 'Security_state.dart';

class SecurityBloc extends Bloc<SecurityEvent, SecurityState> {
  SecurityBloc() : super(SecurityInitial());

  @override
  Stream<SecurityState> mapEventToState(SecurityEvent event) async* {
    // TODO: Implement event handlers
  }
}
