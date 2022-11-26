
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inspire_investors/core/error/error.dart';
import 'package:inspire_investors/features/sign_up/domain/entities/sign_up.dart';
import 'package:inspire_investors/features/sign_up/domain/usecases/post_sign_up_data.dart';
import 'package:inspire_investors/features/sign_up/presentation/bloc/signup_bloc.dart';
import 'package:inspire_investors/util/input_validation.dart';
import 'package:mockito/mockito.dart';

class MockPostSignUpData extends Mock
      implements PostSignUpData {}


class MockInputValidator extends Mock implements InputValidator {}

void main() {
  const signUp = SignUp(name: 'karo', email: 'edawarekaro@gmail.com',password: 'pass',confirmPassword: 'pass');

  SignUpBloc bloc;
  MockPostSignUpData mockPostSignUpData;
  MockInputValidator mockInputValidator;

  mockPostSignUpData = MockPostSignUpData();
  mockInputValidator = MockInputValidator();

  bloc = SignUpBloc(
    signUpData: mockPostSignUpData,
    inputValidator: mockInputValidator,
  );

  test('initialState should be Empty', () {
    // assert
    expect(bloc.initialState, equals(Empty()));
  });

  test(
    'should emit [Error] when the input is invalid',
        () async {
      // arrange
      when(mockInputValidator.isCorrectEmailFormat(""))
          .thenReturn(Left(InvalidInputFailure()));
      // assert later
      final expected = [
        // The initial state is always emitted first
        Empty(),
        Error(message: INVALID_INPUT_FAILURE_MESSAGE),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      // act
     // bloc.add(PostForSignUp);
    },
  );
}