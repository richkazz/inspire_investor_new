import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inspire_investors/features/change_password/presentation/bloc/change_password_bloc.dart';
import '../../../../widgets/widgets.dart';
import '../../change_password_injection_container.dart';
import '../widgets/widgets.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }



  BlocProvider<ChangePasswordBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ChangePasswordBloc>(),
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
                  text1: "Confirm New Password",
                  text2: "Set new account password",
                ),
                const SizedBox(height: 35),
                // Bottom half
                const ChangePasswordControl(),
              ],
            ),
          ),
          GestureDetector(
            child: BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
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
