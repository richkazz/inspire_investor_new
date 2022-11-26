import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fzregex/utils/fzregex.dart';
import 'package:fzregex/utils/pattern.dart';
import 'package:inspire_investors/features/email_verification/presentation/pages/email_verification_page.dart';
import 'package:inspire_investors/features/login/presentation/pages/login_page.dart';
import 'package:inspire_investors/features/sign_up/presentation/pages/signup_page.dart';

import '../bloc/signup_bloc.dart';

class SignUpControl extends StatefulWidget {
  const SignUpControl({Key? key}) : super(key: key);

  @override
  State<SignUpControl> createState() => _SignUpControlState();
}

class _SignUpControlState extends State<SignUpControl> {
  final nameController = TextEditingController();
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
              validator: nameValidator,
              keyboard: TextInputType.text,
              hintText: 'Name',
              controller: nameController),
          const SizedBox(height: 15),
          textField(
              validator: emailValidator,
              keyboard: TextInputType.emailAddress,
              hintText: 'Email',
              controller: emailController),
          const SizedBox(height: 15),
          textField(
              validator: passwordValidator,
              keyboard: TextInputType.text,
              hintText: 'Password',
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
                  child: const Text('SIGN UP'),
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => goTOLoginPage(),
                child: RichText(
                  text: const TextSpan(
                    text: "Already have an account? ",
                    style: TextStyle(fontSize: 16,color: Color.fromARGB(255, 52, 64, 84),fontWeight: FontWeight.w500),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'LOGIN',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 170, 55, 231))),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void goTOLoginPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const LoginPage(),
      ),
    );
  }
  void goTOEmailVerificationPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => EmailVerificationPage(email: emailController.text, text1: 'Welcome to Inspire Investors',),
      ),
    );
  }

  void signUp() {
    goTOEmailVerificationPage();
    if (_formKey.currentState!.validate()) {

      BlocProvider.of<SignUpBloc>(context).add(PostForSignUp(
          name: nameController.text,
          email: emailController.text,
          password: passwordController.text,
          confirmPassword: confirmPasswordController.text));
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

  String? nameValidator(String? str) {
    var nam = str!.trim();
    if (nam.isEmpty) {
      return "Enter a valid name";
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
