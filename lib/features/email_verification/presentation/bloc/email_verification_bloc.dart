import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:inspire_investors/features/email_verification/domain/usecases/post_email_verification.dart';
import 'package:inspire_investors/features/email_verification/domain/usecases/post_request_new_token.dart';

import '../../../../core/error/error.dart';

part 'email_verification_event.dart';
part 'email_verification_state.dart';

class EmailVerificationBloc
    extends Bloc<EmailVerificationEvent, EmailVerificationState> {
  final PostEmailVerification postEmailVerification;
  final PostRequestNewToken postRequestNewToken;
  EmailVerificationBloc({
    required PostEmailVerification verification,
    required PostRequestNewToken requestToken
  })
      : postEmailVerification = verification,
        postRequestNewToken = requestToken,
        super(EmailVerificationInitial()) {

    on<ResendTokenCountDownEnd>((event, emit) async {
      emit(EmailVerificationInitial());
    });

    on<PostEmailVerificationEvent>((event, emit) async {
      emit(Loading());
      final failureOrSignUp =
          await postEmailVerification(Params(token: event.token));
      failureOrSignUp.fold((l) {
        emit(Error(message: mapFailureToMessage(l)));
      }, (r) => emit(Loaded(token: event.token)));
    });

    on<PostRequestNewTokenEvent>((event, emit) async {
      emit(LoadingNewTokenTimeOut());
      final failureOrSignUp =
          await postRequestNewToken(ParamsNewToken(email: event.email));
      failureOrSignUp.fold((l) {
        emit(Error(message: mapFailureToMessage(l)));
      }, (r) => emit(LoadedNewToken(email: event.email)));
    });


  }
}


