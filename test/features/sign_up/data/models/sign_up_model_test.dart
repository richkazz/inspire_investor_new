
import 'dart:convert';

import 'package:inspire_investors/features/sign_up/data/models/sign_up_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inspire_investors/features/sign_up/domain/entities/sign_up.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const signUpModel = SignUpModel(name: 'karo', email: 'edawarekaro@gmail.com',password: 'pass',confirmPassword: 'pass');

  test(
    'should be a subclass of SignUp entity',
        () async {
      // assert
      expect(signUpModel, isA<SignUp>());
    },
  );

  test(
    'should return a valid model',
        () async {
      // arrange
      final Map<String, dynamic> jsonMap =
      json.decode(fixture('sign_up.json'));
      // act
      final result = SignUpModel.fromJson(jsonMap);
      // assert
      expect(result, signUpModel);
    },
  );

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
          () async {
        // act
        final result = signUpModel.toJson();
        // assert
        final expectedJsonMap = {
          "name" : "karo",
          "email" : "edawarekaro@gmail.com",
          "password" : "pass",
          "confirmPassword" : "pass"
        };
        expect(result, expectedJsonMap);
      },
    );
  });
}