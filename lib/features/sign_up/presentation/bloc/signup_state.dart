part of 'signup_bloc.dart';
@immutable
abstract class SignUpState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends SignUpState {}

class Loading extends SignUpState {}

class Loaded extends SignUpState {
  final SignUp signUp;

  Loaded({required this.signUp});
  @override
  List<Object> get props => [signUp];
}

class Error extends SignUpState {
  final String message;

  Error({required this.message});
  @override
  List<Object> get props => [message];
}
