part of 'email_verification_bloc.dart';

abstract class EmailVerificationState extends Equatable {

  @override
  List<Object> get props => [];
}

class EmailVerificationInitial extends EmailVerificationState {
}

class Empty extends EmailVerificationState {}

class Loading extends EmailVerificationState {}

class LoadingNewTokenTimeOut extends EmailVerificationState {}

class Loaded extends EmailVerificationState {
  final String token;

  Loaded({required this.token});
  @override
  List<Object> get props => [token];
}

class LoadedNewToken extends EmailVerificationState {
  final String email;

  LoadedNewToken({required this.email});
  @override
  List<Object> get props => [email];
}



class Error extends EmailVerificationState {
  final String message;

  Error({required this.message});
  @override
  List<Object> get props => [message];
}