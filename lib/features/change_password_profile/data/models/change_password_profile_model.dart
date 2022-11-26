class ChangePasswordProfileModel {
  final String password;
  final String confirmPassword;
  const ChangePasswordProfileModel(
      {required this.password, required this.confirmPassword});

  factory ChangePasswordProfileModel.fromJson(Map<String, dynamic> json) {
    return ChangePasswordProfileModel(
      password: json['password'],
      confirmPassword: json['confirmPassword'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }
}
