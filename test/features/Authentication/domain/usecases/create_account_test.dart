import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sound_mind/core/utils/typedef.dart';
import 'package:sound_mind/features/Authentication/domain/repositories/Authentication_repository.dart';
import 'package:sound_mind/features/Authentication/domain/usecases/create_account.dart';

// Mock class for AuthenticationRepository
class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  late MockAuthenticationRepository mockAuthenticationRepository;
  late CreateAccount usecase;

  setUp(() {
    mockAuthenticationRepository = MockAuthenticationRepository();
    usecase = CreateAccount(repository: mockAuthenticationRepository);
  });

  const tEmail = 'test@example.com';
  const tPassword = 'Password123';
  const tConfirmPassword = 'Password123';
  const tFirstName = 'John';
  const tLastName = 'Doe';
  const tPhoneNumber = '1234567890';
  const tDepressionScore = '5';
  const tResponse = 'Account created successfully';

  final tParams = CreateAccountParams(
    email: tEmail,
    password: tPassword,
    confirmPassword: tConfirmPassword,
    depressionScore: tDepressionScore,
    firstName: tFirstName,
    lastName: tLastName,
    phoneNumber: tPhoneNumber,
  );

  test(
    'should call createAccount on the repository with the correct parameters and return a string response',
    () async {
      // Arrange
      when(() => mockAuthenticationRepository.createAccount(
            email: any(named: 'email'),
            password: any(named: 'password'),
            confirmPassword: any(named: 'confirmPassword'),
            depressionScore: any(named: 'depressionScore'),
            firstName: any(named: 'firstName'),
            lastName: any(named: 'lastName'),
            phoneNumber: any(named: 'phoneNumber'),
          )).thenAnswer((_) async => const Right(tResponse));

      // Act
      final result = await usecase(tParams);

      // Assert
      expect(result, const Right(tResponse));
      verify(() => mockAuthenticationRepository.createAccount(
            email: tEmail,
            password: tPassword,
            confirmPassword: tConfirmPassword,
            depressionScore: tDepressionScore,
            firstName: tFirstName,
            lastName: tLastName,
            phoneNumber: tPhoneNumber,
          )).called(1);
      verifyNoMoreInteractions(mockAuthenticationRepository);
    },
  );
}
