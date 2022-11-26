import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


import 'package:inspire_investors/features/change_password/domain/entities/change_password.dart';

import '../../../../core/error/error.dart';
import '../../domain/usecases/post_change_password_data.dart';
part 'change_password_state.dart';
part 'change_password_event.dart';
class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final PostChangePassword postChangePassword;
  ChangePasswordBloc({required PostChangePassword change})
      : postChangePassword = change,
        super(ChangePasswordInitial()) {
    on<PostForChangePassword>((event, emit) async {
      emit(Loading());
      var changePass = ChangePassword(
        password: event.password,
        email: event.email, confirmPassword: event.confirmPassword,);
      final failureOrSignUp = await postChangePassword(Params(changePassword: changePass));
      failureOrSignUp.fold((l) {
        emit(Error(message: _mapFailureToMessage(l)));
      }, (r) => emit(Loaded(changePassword: changePass)));
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

