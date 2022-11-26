import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inspire_investors/features/sign_up/presentation/pages/signup_page.dart';
import 'package:inspire_investors/features/splash_screen/splash_screen_injection_container.dart';
import '../bloc/splash_screen_bloc.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(context),
    );
  }

  BlocProvider<SplashScreenBloc> buildBody(BuildContext context) {
    const String assetName = 'assets/images/splash_screen_shape_buttom.svg';
    const String paypalMonochromatic = 'assets/images/paypal_monochromatic.svg';
    final ButtonStyle style = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 16),
        backgroundColor: const Color.fromARGB(255, 170, 55, 231));
    final Widget svgIcon =
        SvgPicture.asset(assetName, semanticsLabel: 'background pic');
    final Widget svgIconPaypalMonochromatic = SvgPicture.asset(
      paypalMonochromatic,
      semanticsLabel: 'background pic',
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.width * 0.7,
    );

    return BlocProvider(
        create: (_) => sl<SplashScreenBloc>(),
        child: Stack(
          children: [
            Positioned(
                top: MediaQuery.of(context).size.height * 0.45, child: svgIcon),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: Center(
                child: svgIconPaypalMonochromatic,
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.55,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      'Budget Easy Everyday',
                      style: TextStyle(
                        fontSize: 32,
                        color: Color.fromARGB(255, 170, 55, 231),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: const Text(
                      'Best budget method to keep track of your everyday spending.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 52, 64, 84),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 120,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () => getStarted(context),
                        style: style,
                        child: const Text('NEXT'),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ));
  }

  void getStarted(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const SignUpPage(),
      ),
    );
  }
}
