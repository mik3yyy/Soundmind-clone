import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'Onboarding_event.dart';
part 'Onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(OnboardingInitial());

  @override
  Stream<OnboardingState> mapEventToState(OnboardingEvent event) async* {
    // TODO: Implement event handlers
  }
}
