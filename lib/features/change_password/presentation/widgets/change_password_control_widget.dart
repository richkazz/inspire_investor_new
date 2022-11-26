import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fzregex/utils/fzregex.dart';
import 'package:fzregex/utils/pattern.dart';

import '../../../email_verification/presentation/pages/email_verification_page.dart';
import '../bloc/change_password_bloc.dart';


class ChangePasswordControl extends StatefulWidget {
  const ChangePasswordControl({Key? key}) : super(key: key);

  @override
  State<ChangePasswordControl> createState() => _ChangePasswordControlState();
}

class _ChangePasswordControlState extends State<ChangePasswordControl> {
  final emailController = TextEditingController();
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
              validator: emailValidator,
              keyboard: TextInputType.emailAddress,
              hintText: 'Email',
              controller: emailController),
          const SizedBox(height: 15),
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

  void goTOChangePasswordVerificationPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => EmailVerificationPage(email: emailController.text, text1: 'Confirm New Password',),
      ),
    );
  }
  void signUp() {
   /* BlocProvider.of<ChangePasswordBloc>(context).add(PostForChangePassword(
        email: emailController.text,
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text));*/
    goTOChangePasswordVerificationPage();
    if (_formKey.currentState!.validate()) {

    }
  }

  String? emailValidator(String? str) {
    var ema = str!.toLowerCase().trim();
    if ((Fzregex.hasMatch(ema, FzPattern.email) == false)) {
      return "Enter a valid email address";
    } else {
      return null;
    }
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
