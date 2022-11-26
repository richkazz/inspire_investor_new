import 'package:equatable/equatable.dart';

class ChangePassword extends Equatable {
  final String email;
  final String password;
  final String confirmPassword;

  const ChangePassword(
      {
      required this.email,
      required this.password,
      required this.confirmPassword});

  @override
  List<Object?> get props => [ email, password, confirmPassword];
}
