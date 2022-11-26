
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inspire_investors/features/email_verification/presentation/bloc/email_verification_bloc.dart';
import 'package:inspire_investors/features/email_verification/presentation/widgets/email_verification_control.dart';

import '../../../../widgets/widgets.dart';
import '../../email_verification_injection_container.dart';

class EmailVerificationPage extends StatelessWidget {
  const EmailVerificationPage({super.key, required this.email, required this.text1});
  final String email;
  final String text1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }



  BlocProvider<EmailVerificationBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<EmailVerificationBloc>(),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                // Top half
                TopHalfDisplay(
                  text1: text1,
                  text2: "Verify your account",
                ),
                const SizedBox(height: 35),
                // Bottom half
                EmailVerificationControl(email: email,),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
