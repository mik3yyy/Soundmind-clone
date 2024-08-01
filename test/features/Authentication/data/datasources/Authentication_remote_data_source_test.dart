import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sound_mind/core/network/network.dart';
import 'package:sound_mind/features/Authentication/data/datasources/Authentication_remote_data_source.dart';
import 'package:sound_mind/features/Authentication/data/models/User_model.dart';

// Mock class for Network
class MockNetwork extends Mock implements Network {}

void main() {
  late MockNetwork mockNetwork;
  late AuthenticationRemoteDataSourceImpl dataSource;

  setUp(() {
    mockNetwork = MockNetwork();
    dataSource = AuthenticationRemoteDataSourceImpl(network: mockNetwork);
  });

  group('createAccount', () {
    const tEmail = 'test@example.com';
    const tPassword = 'Password123';
    const tConfirmPassword = 'Password123';
    const tFirstName = 'John';
    const tLastName = 'Doe';
    const tPhoneNumber = '1234567890';
    const tDepressionScore = '5';

    test('should call network with correct parameters', () async {
      // Arrange
      when(() => mockNetwork.call(
                any(),
                any(),
                data: any(named: 'data'),
              ))
          .thenAnswer(
              (_) async => Response(requestOptions: RequestOptions(path: '')));

      // Act
      await dataSource.createAccount(
        email: tEmail,
        password: tPassword,
        confirmPassword: tConfirmPassword,
        depressionScore: tDepressionScore,
        firstName: tFirstName,
        lastName: tLastName,
        phoneNumber: tPhoneNumber,
      );

      // Assert
      verify(() => mockNetwork.call(
            "/Registration",
            RequestMethod.post,
            data: {
              "email": tEmail,
              "firstName": tFirstName,
              "lastName": tLastName,
              "password": tPassword,
              "phoneNumber": tPhoneNumber,
              "passwordConfirmation": tConfirmPassword,
              "depressionSeverityScore": tDepressionScore
            },
          )).called(1);
      verifyNoMoreInteractions(mockNetwork);
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

    test('should call network with correct parameters and return UserModel',
        () async {
      // Arrange
      when(() => mockNetwork.call(
                any(),
                any(),
                data: any(named: 'data'),
              ))
          .thenAnswer((_) async => Response(
              data: tUserModel.toJson(),
              requestOptions: RequestOptions(path: '')));

      // Act
      final result = await dataSource.login(email: tEmail, password: tPassword);

      // Assert
      expect(result, tUserModel);
      verify(() => mockNetwork.call(
            "/login",
            RequestMethod.post,
            data: {
              "email": tEmail,
              "password": tPassword,
            },
          )).called(1);
      verifyNoMoreInteractions(mockNetwork);
    });
  });

  group('verifyEmail', () {
    const tOtp = '123456';
    final tUserModel = UserModel(
        email: 'test@example.com',
        firstName: 'John',
        lastName: 'Doe',
        phoneNumber: '1234567890');

    test('should call network with correct parameters and return UserModel',
        () async {
      // Arrange
      when(() => mockNetwork.call(
                any(),
                any(),
                data: any(named: 'data'),
              ))
          .thenAnswer((_) async => Response(
              data: tUserModel.toJson(),
              requestOptions: RequestOptions(path: '')));

      // Act
      final result = await dataSource.verifyEmail(otp: tOtp);

      // Assert
      expect(result, tUserModel);
      verify(() => mockNetwork.call(
            "/verify",
            RequestMethod.post,
            data: {"otp": tOtp},
          )).called(1);
      verifyNoMoreInteractions(mockNetwork);
    });
  });
}
