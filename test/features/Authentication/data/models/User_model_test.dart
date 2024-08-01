import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:sound_mind/features/Authentication/data/models/User_model.dart';

void main() {
  const tEmail = 'test@example.com';
  const tFirstName = 'John';
  const tLastName = 'Doe';
  const tPhoneNumber = '1234567890';

  final tUserModel = UserModel(
    email: tEmail,
    firstName: tFirstName,
    lastName: tLastName,
    phoneNumber: tPhoneNumber,
  );

  group('UserModel', () {
    test('should correctly implement copyWith', () {
      const newEmail = 'new@example.com';
      final result = tUserModel.copyWith(email: newEmail);

      expect(result.email, newEmail);
      expect(result.firstName, tFirstName);
      expect(result.lastName, tLastName);
      expect(result.phoneNumber, tPhoneNumber);
    });

    test('should correctly convert to Map', () {
      final result = tUserModel.toMap();

      expect(result, {
        'email': tEmail,
        'firstName': tFirstName,
        'lastName': tLastName,
        'phoneNumber': tPhoneNumber,
      });
    });

    test('should correctly create from Map', () {
      final map = {
        'email': tEmail,
        'firstName': tFirstName,
        'lastName': tLastName,
        'phoneNumber': tPhoneNumber,
      };

      final result = UserModel.fromMap(map);

      expect(result, tUserModel);
    });

    test('should correctly convert to JSON', () {
      final result = tUserModel.toJson();

      final expectedJsonString = json.encode({
        'email': tEmail,
        'firstName': tFirstName,
        'lastName': tLastName,
        'phoneNumber': tPhoneNumber,
      });

      expect(result, expectedJsonString);
    });

    test('should correctly create from JSON', () {
      final jsonString = json.encode({
        'email': tEmail,
        'firstName': tFirstName,
        'lastName': tLastName,
        'phoneNumber': tPhoneNumber,
      });

      final result = UserModel.fromJson(jsonString);

      expect(result, tUserModel);
    });

    test('should correctly override toString', () {
      final result = tUserModel.toString();

      expect(result,
          'UserModel(email: $tEmail, firstName: $tFirstName, lastName: $tLastName, phoneNumber: $tPhoneNumber)');
    });
  });
}
