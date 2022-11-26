import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:inspire_investors/features/email_verification/presentation/bloc/email_verification_bloc.dart';

import '../../../../widgets/notify_indicator.dart';
import '../../../login/presentation/pages/login_page.dart';

class EmailVerificationControl extends StatefulWidget {
  const EmailVerificationControl({Key? key, required this.email})
      : super(key: key);
  final String email;
  @override
  State<EmailVerificationControl> createState() =>
      _EmailVerificationControlState();
}

class _EmailVerificationControlState extends State<EmailVerificationControl> {
  final token1Controller = TextEditingController();
  final token2Controller = TextEditingController();
  final token3Controller = TextEditingController();
  final token4Controller = TextEditingController();
  CountdownTimerController? countDownController;
  late FocusNode myFocusNode1, myFocusNode2, myFocusNode3, myFocusNode4;
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;
  bool isNotifyLoading = false;
  @override
  void initState() {
    super.initState();
    countDownController =
        CountdownTimerController(endTime: endTime, onEnd: onRequestNewTokenEnd);
    token1Controller.addListener(() {
      currentFocusedField = 1;
    });
    token2Controller.addListener(() {
      currentFocusedField = 2;
    });
    token3Controller.addListener(() {
      currentFocusedField = 3;
    });
    token4Controller.addListener(() {
      currentFocusedField = 4;
    });

    myFocusNode1 = FocusNode();
    myFocusNode2 = FocusNode();
    myFocusNode3 = FocusNode();
    myFocusNode4 = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode1.dispose();
    myFocusNode2.dispose();
    myFocusNode3.dispose();
    myFocusNode4.dispose();
    countDownController!.dispose();
    super.dispose();
  }

  int currentFocusedField = 1;
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
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: RichText(
              text: TextSpan(
                text: "A verification code has been sent to your email ",
                style: const TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 52, 64, 84),
                    fontWeight: FontWeight.w400),
                children: <TextSpan>[
                  TextSpan(
                      text: widget.email,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 170, 55, 231))),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Row(
              children: [
                Expanded(
                  child: textField(
                      validator: tokenValidator,
                      focusNode: myFocusNode1,
                      keyboard:
                          const TextInputType.numberWithOptions(signed: true),
                      hintText: '',
                      controller: token1Controller),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: textField(
                      focusNode: myFocusNode2,
                      validator: tokenValidator,
                      keyboard:
                          const TextInputType.numberWithOptions(signed: true),
                      hintText: '',
                      controller: token2Controller),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: textField(
                      focusNode: myFocusNode3,
                      validator: tokenValidator,
                      keyboard:
                          const TextInputType.numberWithOptions(signed: true),
                      hintText: '',
                      controller: token3Controller),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: textField(
                      focusNode: myFocusNode4,
                      validator: tokenValidator,
                      keyboard:
                          const TextInputType.numberWithOptions(signed: true),
                      hintText: '',
                      controller: token4Controller),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          const Center(
            child: Text(
              "Didn't get OTP code yet?",
              style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 52, 64, 84),
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 50,
            child: BlocBuilder<EmailVerificationBloc, EmailVerificationState>(
              builder: (context, state) {
                if (state is EmailVerificationInitial) {
                  return resendOTPButton();
                }else if (state is Loading) {
                  Future.delayed(Duration.zero).whenComplete((){
                    isNotifyLoading = true;
                    Notify.loading(context, "verifying...");
                  });

                  return resendOTPButton();
                } else if (state is LoadingNewTokenTimeOut) {
                  return resendOTPCountDown();
                } else if (state is Error) {
                  Future.delayed(Duration.zero).whenComplete((){
                    if(isNotifyLoading){
                      isNotifyLoading = false;
                      Navigator.pop(context);
                    }
                    Notify.error(context, state.message);
                  });
                  countDownController!.disposeTimer();
                  onRequestNewTokenEnd();
                  return resendOTPButton();
                  //return Notify.error(state.message, context);
                } else {
                  return Container();
                }
                // We're going to also check for the other states
              },
            ),
          ),
          const SizedBox(height: 60),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 120,
                height: 40,
                child: ElevatedButton(
                  onPressed: signUp,
                  style: style,
                  child: const Text('VERIFY'),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget resendOTPCountDown(){
    int endTime1 = DateTime.now().millisecondsSinceEpoch + 1000 * 30;
    countDownController!.endTime = endTime1;
    return Column(
      children: [
        const SizedBox(height: 25),
        CountdownTimer(
          controller: countDownController,
          endTime: endTime,
          onEnd: onRequestNewTokenEnd,
          widgetBuilder: (_, CurrentRemainingTime? time) {
            return Text('Retry in: ${time!.sec}',
                style: const TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 52, 64, 84),
                    fontWeight: FontWeight.w500));
          },
        ),
      ],
    );
  }
  Widget resendOTPButton(){
    return TextButton(
      onPressed: () => requestForNewToken(),
      child: const Text(
        "Resend OTP",
        style: TextStyle(
            fontSize: 16,
            color: Color.fromARGB(255, 170, 55, 231),
            fontWeight: FontWeight.w700),
      ),
    );
  }



  void onRequestNewTokenEnd() {
    BlocProvider.of<EmailVerificationBloc>(context)
        .add(ResendTokenCountDownEnd());
  }

  void requestForNewToken() {
    BlocProvider.of<EmailVerificationBloc>(context)
        .add(PostRequestNewTokenEvent(email: widget.email));
  }
  void goTOLoginPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const LoginPage(),
      ),
    );
  }
  void signUp() {
    /*var token = token1Controller.text +
        token2Controller.text +
        token3Controller.text +
        token4Controller.text;
    BlocProvider.of<EmailVerificationBloc>(context)
        .add(PostEmailVerificationEvent(token: token));*/
    goTOLoginPage();
    if (_formKey.currentState!.validate()) {}
  }

  String? tokenValidator(String? str) {
    var ema = str!.toLowerCase().trim();
    if (ema.isEmpty) {
      return "Enter a valid number";
    } else {
      return null;
    }
  }

  void onNumberEntered(int curr) {
    if (curr == 2 && token1Controller.text.isNotEmpty) {
      myFocusNode2.requestFocus();
      currentFocusedField++;
    } else if (curr == 3 && token2Controller.text.isNotEmpty) {
      myFocusNode3.requestFocus();
      currentFocusedField++;
    } else if (curr == 4 && token3Controller.text.isNotEmpty) {
      myFocusNode4.requestFocus();
      currentFocusedField++;
    } else if (curr == 5) {
      signUp();
    }
  }

  TextFormField textField(
      {required TextInputType keyboard,
      required String? hintText,
      required Function validator,
      required FocusNode focusNode,
      bool obscureText = false,
      required TextEditingController controller}) {
    return TextFormField(
        validator: (val) => validator(val),
        controller: controller,
        keyboardType: keyboard,
        focusNode: focusNode,
        maxLength: 1,
        onChanged: (val) {
          onNumberEntered(currentFocusedField + 1);
        },
        obscureText: obscureText,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: hintText,
        ));
  }
}
