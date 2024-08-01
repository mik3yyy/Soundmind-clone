import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sound_mind/core/error/failures.dart';
import 'package:sound_mind/core/network/network.dart';
import 'package:sound_mind/features/Authentication/data/datasources/Authentication_remote_data_source.dart';
import 'package:sound_mind/features/Authentication/data/models/User_model.dart';
import 'package:sound_mind/features/Authentication/data/repositories/Authentication_repository_impl.dart';

// Mock class for AuthenticationRemoteDataSource
class MockAuthenticationRemoteDataSource extends Mock
    implements AuthenticationRemoteDataSource {}

void main() {
  late MockAuthenticationRemoteDataSource mockRemoteDataSource;
  late AuthenticationRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockAuthenticationRemoteDataSource();
    repository = AuthenticationRepositoryImpl(
        authenticationRemoteDataSource: mockRemoteDataSource);
  });

  group('createAccount', () {
    const tEmail = 'test@example.com';
    const tPassword = 'Password123';
    const tConfirmPassword = 'Password123';
    const tFirstName = 'John';
    const tLastName = 'Doe';
    const tPhoneNumber = '1234567890';
    const tDepressionScore = '5';

    test('should call createAccount on the remote data source', () async {
      // Arrange
      when(() => mockRemoteDataSource.createAccount(
            email: any(named: 'email'),
            password: any(named: 'password'),
            depressionScore: any(named: 'depressionScore'),
            confirmPassword: any(named: 'confirmPassword'),
            firstName: any(named: 'firstName'),
            lastName: any(named: 'lastName'),
            phoneNumber: any(named: 'phoneNumber'),
          )).thenAnswer((_) async => Future.value());

      // Act
      final result = await repository.createAccount(
        email: tEmail,
        password: tPassword,
        depressionScore: tDepressionScore,
        confirmPassword: tConfirmPassword,
        firstName: tFirstName,
        lastName: tLastName,
        phoneNumber: tPhoneNumber,
      );

      // Assert
      expect(result, const Right(null));
      verify(() => mockRemoteDataSource.createAccount(
            email: tEmail,
            password: tPassword,
            depressionScore: tDepressionScore,
            confirmPassword: tConfirmPassword,
            firstName: tFirstName,
            lastName: tLastName,
            phoneNumber: tPhoneNumber,
          )).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return ServerFailure when an ApiError is thrown', () async {
      // Arrange
      final tError = ApiError(errorDescription: "errorDescription");
      when(() => mockRemoteDataSource.createAccount(
            email: any(named: 'email'),
            password: any(named: 'password'),
            depressionScore: any(named: 'depressionScore'),
            confirmPassword: any(named: 'confirmPassword'),
            firstName: any(named: 'firstName'),
            lastName: any(named: 'lastName'),
            phoneNumber: any(named: 'phoneNumber'),
          )).thenThrow(tError);

      // Act
      final result = await repository.createAccount(
        email: tEmail,
        password: tPassword,
        depressionScore: tDepressionScore,
        confirmPassword: tConfirmPassword,
        firstName: tFirstName,
        lastName: tLastName,
        phoneNumber: tPhoneNumber,
      );

      // Assert
      expect(result, Left(ServerFailure(tError.errorDescription)));
      verify(() => mockRemoteDataSource.createAccount(
            email: tEmail,
            password: tPassword,
            depressionScore: tDepressionScore,
            confirmPassword: tConfirmPassword,
            firstName: tFirstName,
            lastName: tLastName,
            phoneNumber: tPhoneNumber,
          )).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });

  group('login', () {
    const tEmail = 'test@example.com';
    const tPassword = 'Password123';
    final tUserModel = UserModel(
        email: tEmail,
        firstName: 'John',
        lastName: 'Doe',
        phoneNumber: '1234567890');

    test('should call login on the remote data source', () async {
      // Arrange
      when(() => mockRemoteDataSource.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => tUserModel);

      // Act
      final result = await repository.login(email: tEmail, password: tPassword);

      // Assert
      expect(result, Right(tUserModel));
      verify(() => mockRemoteDataSource.login(
            email: tEmail,
            password: tPassword,
          )).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return ServerFailure when an ApiError is thrown', () async {
      // Arrange
      final tError = ApiError(errorDescription: "errorDescription");
      when(() => mockRemoteDataSource.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenThrow(tError);

      // Act
      final result = await repository.login(email: tEmail, password: tPassword);

      // Assert
      expect(result, Left(ServerFailure(tError.errorDescription)));
      verify(() => mockRemoteDataSource.login(
            email: tEmail,
            password: tPassword,
          )).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });

  group('verifyEmail', () {
    const tOtp = '123456';
    final tUserModel = UserModel(
        email: 'test@example.com',
        firstName: 'John',
        lastName: 'Doe',
        phoneNumber: '1234567890');

    test('should call verifyEmail on the remote data source', () async {
      // Arrange
      when(() => mockRemoteDataSource.verifyEmail(
            otp: any(named: 'otp'),
          )).thenAnswer((_) async => tUserModel);

      // Act
      final result = await repository.verifyEmail(otp: tOtp);

      // Assert
      expect(result, Right(tUserModel));
      verify(() => mockRemoteDataSource.verifyEmail(
            otp: tOtp,
          )).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return ServerFailure when an ApiError is thrown', () async {
      // Arrange
      final tError = ApiError(errorDescription: "errorDescription");
      when(() => mockRemoteDataSource.verifyEmail(
            otp: any(named: 'otp'),
          )).thenThrow(tError);

      // Act
      final result = await repository.verifyEmail(otp: tOtp);

      // Assert
      expect(result, Left(ServerFailure(tError.errorDescription)));
      verify(() => mockRemoteDataSource.verifyEmail(
            otp: tOtp,
          )).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });
}
