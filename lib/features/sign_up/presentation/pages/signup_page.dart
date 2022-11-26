import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inspire_investors/features/sign_up/presentation/bloc/signup_bloc.dart';
import 'package:inspire_investors/widgets/notify_indicator.dart';

import '../../../../widgets/widgets.dart';
import '../../signup_injection_container.dart';
import '../widgets/widgets.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }

  BlocProvider<SignUpBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SignUpBloc>(),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                // Top half
                const TopHalfDisplay(
                  text1: "Welcome to Inspire Investors",
                  text2: "Create a new account",
                ),
                const SizedBox(height: 35),
                // Bottom half
                const SignUpControl(),
              ],
            ),
          ),
          GestureDetector(
            child: BlocBuilder<SignUpBloc, SignUpState>(
              builder: (context, state) {
                if (state is Empty) {
                  return Container();
                } else if (state is Loading) {
                  Future.delayed(Duration.zero).whenComplete((){
                    Notify.loading(context, "verifying...");
                  });
                  return Container();
                } else if (state is Loaded) {
                  return Container();
                } else if (state is Error) {
                  return Container();
                  //return Notify.error(state.message, context);
                } else {
                  return Container();
                }
                // We're going to also check for the other states
              },
            ),
          ),
        ],
      ),
    );
  }
}
