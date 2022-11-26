
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inspire_investors/util/input_validation.dart';

void main() {
  InputValidator inputValidator = InputValidator();



  group('stringToUnsignedInt', () {
    test(
      'should return true if the email format is correct',
          () async {
        // arrange
        const str = 'edawarekaro@gmail.com';
        // act
        final result = inputValidator.isCorrectEmailFormat(str);
        // assert
        expect(result, const Right(str));
      },
    );
  });

  test(
    'should return a failure when the string is not an integer',
        () async {
      // arrange
      const str = 'edaw';
      // act
      final result = inputValidator.isCorrectEmailFormat(str);
      // assert
      expect(result, Left(InvalidInputFailure()));
    },
  );
}