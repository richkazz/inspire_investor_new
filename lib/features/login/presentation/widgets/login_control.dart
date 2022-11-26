import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fzregex/utils/fzregex.dart';
import 'package:fzregex/utils/pattern.dart';
import 'package:inspire_investors/features/change_password/presentation/pages/change_password_page.dart';
import 'package:inspire_investors/features/login/domain/repositories/login_repositories.dart';
import 'package:inspire_investors/features/login/domain/usecases/post_login.dart';

import '../../../../widgets/notify_indicator.dart';
import '../bloc/login_bloc.dart';


class SignUpControl extends StatefulWidget {
  const SignUpControl({Key? key}) : super(key: key);

  @override
  State<SignUpControl> createState() => _SignUpControlState();
}

class _SignUpControlState extends State<SignUpControl> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isNotifyLoading = false;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 16),
        backgroundColor: const Color.fromARGB(255, 170, 55, 231));
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state is Empty) {
                return Container();
              } else if (state is Loading) {
                Future.delayed(Duration.zero).whenComplete((){
                  isNotifyLoading = true;
                  Notify.loading(context, "verifying...");
                });
                return Container();
              } else if (state is Loaded) {
                return Container();
              } else if (state is Error) {
                Future.delayed(Duration.zero).whenComplete((){
                  if(isNotifyLoading){
                    isNotifyLoading = false;
                    Navigator.pop(context);
                  }
                  Notify.error(context, state.message);
                });
                return Container();
                //return Notify.error(state.message, context);
              } else {
                return Container();
              }
              // We're going to also check for the other states
            },
          ),
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
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed:goTOForgetPasswordPage,
                child: const Text(
                  "Forgot Password?",
                  style: TextStyle(fontSize: 16,color: Color.fromARGB(255, 52, 64, 84)),
                ),
              )
            ],
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 120,
                height: 40,
                child: ElevatedButton(
                  onPressed: loginMethod,
                  style: style,
                  child: const Text('Login'),
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => goTOSignUpPage(),
                child: RichText(
                  text: const TextSpan(
                    text: "Don’t have an account? ",
                    style: TextStyle(fontSize: 16,color: Color.fromARGB(255, 52, 64, 84),fontWeight: FontWeight.w500),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Sign up',
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
  void goTOForgetPasswordPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const ChangePasswordPage(),
      ),
    );
  }

  void loginMethod() async {
    BlocProvider.of<LoginBloc>(context).add(PostLoginEvent(
        email: emailController.text,
        password: passwordController.text));

    if (_formKey.currentState!.validate()) {

    }
  }
  void goTOSignUpPage(){
    Navigator.pop(context);
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
