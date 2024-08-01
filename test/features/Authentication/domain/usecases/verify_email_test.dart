import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sound_mind/features/Authentication/data/models/User_model.dart';
import 'package:sound_mind/features/Authentication/domain/repositories/Authentication_repository.dart';
import 'package:sound_mind/features/Authentication/domain/usecases/verify_email.dart';

// Mock class for AuthenticationRepository
class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  late MockAuthenticationRepository mockAuthenticationRepository;
  late VerifyEmail usecase;

  setUp(() {
    mockAuthenticationRepository = MockAuthenticationRepository();
    usecase = VerifyEmail(repository: mockAuthenticationRepository);
  });

  const tOtp = '123456';

  final tParams = VerifyEmailParams(otp: tOtp);

  test(
    'should call verifyEmail on the repository with the correct parameters',
    () async {
      // Arrange
      when(() => mockAuthenticationRepository.verifyEmail(
            otp: any(named: 'otp'),
          )).thenAnswer(
        (_) async => Right(
          UserModel(
              email: "email",
              firstName: "firstName",
              lastName: "lastName",
              phoneNumber: "phoneNumber"),
        ),
      );

      // Act
      await usecase(tParams);

      // Assert
      verify(() => mockAuthenticationRepository.verifyEmail(
            otp: tOtp,
          )).called(1);
      verifyNoMoreInteractions(mockAuthenticationRepository);
    },
  );
}
