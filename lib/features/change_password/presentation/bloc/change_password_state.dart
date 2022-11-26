part of 'change_password_bloc.dart';

abstract class ChangePasswordState extends Equatable {
  @override
  List<Object> get props => [];
}

class ChangePasswordInitial extends ChangePasswordState {

}


class Empty extends ChangePasswordState {}

class Loading extends ChangePasswordState {}

class Loaded extends ChangePasswordState {
  final ChangePassword changePassword;

  Loaded({required this.changePassword});
  @override
  List<Object> get props => [changePassword];
}

class Error extends ChangePasswordState {
  final String message;

  Error({required this.message});
  @override
  List<Object> get props => [message];
}