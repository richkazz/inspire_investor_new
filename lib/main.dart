import 'package:flutter/material.dart';
import 'package:inspire_investors/injection_container.dart' as di;
import 'features/splash_screen/presentation/pages/splash_screen_page.dart';

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
      home: const SplashScreenPage(),
    );
  }
}