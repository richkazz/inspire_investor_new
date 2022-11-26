import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/error.dart';
import '../../domain/entities/login.dart';
import '../../domain/usecases/post_login.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final PostLogin postLogin;
  LoginBloc({required PostLogin login})
      : postLogin = login,
        super(LoginInitial()) {
    on<PostLoginEvent>((event, emit) async {
      emit(Loading());
      var login = Login(
          password: event.password,
          email: event.email,);
      final failureOrSignUp = await postLogin(Params(login: login));
      failureOrSignUp.fold((l) {
        emit(Error(message: _mapFailureToMessage(l)));
      }, (r) => emit(Loaded(login: login)));
    });
  }
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

