part of 'email_verification_bloc.dart';

abstract class EmailVerificationEvent extends Equatable {
  const EmailVerificationEvent();
}

class PostEmailVerificationEvent extends EmailVerificationEvent {
  final String token;

  const PostEmailVerificationEvent({
    required this.token,
  });

  @override
  List<Object> get props => [token];
}

class PostRequestNewTokenEvent extends EmailVerificationEvent {
  final String email;

  const PostRequestNewTokenEvent({
    required this.email,
  });

  @override
  List<Object> get props => [email];
}

class ResendTokenCountDownEnd extends EmailVerificationEvent{
  @override
  List<Object> get props => [];
}


