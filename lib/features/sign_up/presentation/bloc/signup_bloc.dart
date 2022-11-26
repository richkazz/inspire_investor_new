import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../../../core/error/error.dart';
import '../../../../core/error/failures.dart';
import '../../../../util/input_validation.dart';
import '../../domain/entities/sign_up.dart';
import '../../domain/usecases/post_sign_up_data.dart';

part 'signup_event.dart';
part 'signup_state.dart';


class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final PostSignUpData postSignUpData;
  final InputValidator inputValidator;

  SignUpBloc({
    required PostSignUpData signUpData,
    required this.inputValidator,
  })  : postSignUpData = signUpData,
        super(Empty()) {
    on<EmptyEvent>((event, emit) async {
      print(6);
      emit(Loading());
    });
    on<PostForSignUp>((event, emit) async {
      //emit(Loading());

      final inputEither = inputValidator.isCorrectEmailFormat(event.email);
      if (inputEither.isLeft()) {
        emit(Error(message: INVALID_INPUT_FAILURE_MESSAGE));
      } else if (inputEither.isRight()) {
        emit(Loading());
        var signUp = SignUp(
            name: event.name,
            password: event.password,
            email: event.email,
            confirmPassword: event.confirmPassword);
        final failureOrSignUp = await postSignUpData(Params(signUp: signUp));
        failureOrSignUp.fold((l) {
          emit(Error(message: _mapFailureToMessage(l)));
        }, (r) => emit(Loaded(signUp: signUp)));
      }
    });
  }

  @override
  SignUpState get initialState => Empty();

  Stream<SignUpState> mapEventToState(
    SignUpEvent event,
  ) async* {
    print(4);
    if (event is PostForSignUp) {
      final inputEither = inputValidator.isCorrectEmailFormat(event.email);

      yield* inputEither.fold(
        (failure) async* {
          yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);
        },
        (integer) async* {
          yield Loading();
          var signUp = SignUp(
              name: event.name,
              password: event.password,
              email: event.email,
              confirmPassword: event.confirmPassword);
          final failureOrSignUp = await postSignUpData(Params(signUp: signUp));

          yield* _eitherLoadedOrErrorState(failureOrSignUp);
        },
      );
    }
  }
}

Stream<SignUpState> _eitherLoadedOrErrorState(
  Either<Failure, SignUp> failureOrTrivia,
) async* {
  yield failureOrTrivia.fold(
    (failure) => Error(message: _mapFailureToMessage(failure)),
    (signUp) => Loaded(signUp: signUp),
  );
}

String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    case CacheFailure:
      return CACHE_FAILURE_MESSAGE;
    default:
      return 'Unexpected error';
  }
}
