import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../../../../widgets/widgets.dart';
import '../bloc/login_bloc.dart';
import '../widgets/login_control.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }

  BlocProvider<LoginBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LoginBloc>(),
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
                  text2: "Login to your account",
                ),

                const SizedBox(height: 35),
                // Bottom half
                const SignUpControl(),
              ],
            ),
          ),

        ],
      )
    );
  }


}
