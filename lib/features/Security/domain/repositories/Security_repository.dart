import 'package:sound_mind/core/utils/typedef.dart';

abstract class SecurityRepository {
  ResultFuture<bool> checkPin({required String pin});
  ResultVoid savePin({required String pin});
  ResultVoid clearPin();
  ResultFuture<bool> isPinSet();
}
