import '../../domain/entities/change_password.dart';


class ChangePasswordModel extends ChangePassword {
  const ChangePasswordModel(
      {
      required String email,
      required String password,
      required String confirmPassword})
      : super(
            email: email,
            password: password,
            confirmPassword: confirmPassword);

  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) {
    return ChangePasswordModel(
      email: json['email'],
      password: json['password'],
      confirmPassword: json['confirmPassword'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }
}
