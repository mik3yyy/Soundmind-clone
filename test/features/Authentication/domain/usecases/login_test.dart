import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sound_mind/features/Authentication/data/models/User_model.dart';
import 'package:sound_mind/features/Authentication/domain/repositories/Authentication_repository.dart';
import 'package:sound_mind/features/Authentication/domain/usecases/login.dart';

// Mock class for AuthenticationRepository
class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  late MockAuthenticationRepository mockAuthenticationRepository;
  late Login usecase;

  setUp(() {
    mockAuthenticationRepository = MockAuthenticationRepository();
    usecase = Login(repository: mockAuthenticationRepository);
  });

  const tEmail = 'test@example.com';
  const tPassword = 'Password123';

  final tParams = LoginParams(
    email: tEmail,
    password: tPassword,
  );

  test(
    'should call login on the repository with the correct parameters',
    () async {
      // Arrange
      when(() => mockAuthenticationRepository.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
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
      verify(() => mockAuthenticationRepository.login(
            email: tEmail,
            password: tPassword,
          )).called(1);
      verifyNoMoreInteractions(mockAuthenticationRepository);
    },
  );
}
