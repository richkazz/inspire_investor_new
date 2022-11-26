part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();
}
class PostForChangePassword extends ChangePasswordEvent {
  final String email;
  final String password;
  final String confirmPassword;

  const PostForChangePassword(
      {
        required this.email,
        required this.password,
        required this.confirmPassword});

  @override
  List<Object> get props => [ email, password, confirmPassword];
}

