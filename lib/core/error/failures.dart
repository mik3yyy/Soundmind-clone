import 'package:equatable/equatable.dart';
import 'package:sound_mind/core/utils/typedef.dart';

abstract class Failure extends Equatable {
  final String message;
  final DataMap? data;

  const Failure(this.message, {this.data});

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message, {super.data});
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}
