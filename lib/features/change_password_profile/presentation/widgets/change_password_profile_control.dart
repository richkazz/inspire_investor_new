import 'package:flutter/material.dart';
import 'package:fzregex/utils/fzregex.dart';
import 'package:fzregex/utils/pattern.dart';
import 'package:inspire_investors/features/change_password_profile/data/models/change_password_profile_model.dart';

import '../../data/data_source/change_Password_profile_remote_data_source.dart';

class ChangePasswordProfileControl extends StatefulWidget {
  const ChangePasswordProfileControl({Key? key, required this.submitChangePassword}) : super(key: key);
  final Function submitChangePassword;
  @override
  State<ChangePasswordProfileControl> createState() =>
      _ChangePasswordControlState();
}

class _ChangePasswordControlState extends State<ChangePasswordProfileControl> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 16),
        backgroundColor: const Color.fromARGB(255, 170, 55, 231));
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          textField(
              validator: passwordValidator,
              keyboard: TextInputType.text,
              hintText: 'New password',
              obscureText: true,
              controller: passwordController),
          const SizedBox(height: 15),
          textField(
              validator: confirmPasswordValidator,
              keyboard: TextInputType.text,
              hintText: 'Confirm Password',
              obscureText: true,
              controller: confirmPasswordController),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 120,
                height: 40,
                child: ElevatedButton(
                  onPressed: signUp,
                  style: style,
                  child: const Text('Confirm'),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void signUp() {
    ChangePasswordProfileModel model = ChangePasswordProfileModel(
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text);
    widget.submitChangePassword(model);
    if (_formKey.currentState!.validate()) {}
  }

  String? passwordValidator(String? str) {
    if ((Fzregex.hasMatch(str!, FzPattern.passwordNormal1) == false)) {
      return "Enter a valid password";
    } else {
      return null;
    }
  }

  String? confirmPasswordValidator(String? str) {
    if (passwordController.text != confirmPasswordController.text) {
      return "Confirm password must be the same as password";
    } else {
      return null;
    }
  }
}

TextFormField textField(
    {required TextInputType keyboard,
    required String? hintText,
    required Function validator,
    bool obscureText = false,
    required TextEditingController controller}) {
  return TextFormField(
      validator: (val) => validator(val),
      controller: controller,
      keyboardType: keyboard,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hintText,
      ));
}
