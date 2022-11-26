import 'package:flutter/material.dart';
import 'package:inspire_investors/features/change_password/presentation/pages/change_password_page.dart';
import 'package:inspire_investors/features/sign_up/presentation/pages/signup_page.dart';
import 'package:inspire_investors/injection_container.dart' as di;

import 'features/change_password_profile/presentation/pages/change_password_profile_page.dart';
import 'features/email_verification/presentation/pages/email_verification_page.dart';

void main() async{
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Trivia',
      theme: ThemeData(
        primaryColor: Colors.green.shade800,
      ),
      home: const SignUpPage(),
    );
  }
}