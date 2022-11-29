
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/colors/app_color.dart';

class NavBarNavigationButton extends StatefulWidget {
  const NavBarNavigationButton({Key? key}) : super(key: key);

  @override
  State<NavBarNavigationButton> createState() => _NavBarNavigationButtonState();
}

class _NavBarNavigationButtonState extends State<NavBarNavigationButton> {
  String homeImage = 'assets/images/home_line.svg';
  String expenditureNavButton = 'assets/images/expenditure_nav_botton.svg';
  String transactionNavButton = 'assets/images/transactions_nav_button.svg';
  String profileNaButton = 'assets/images/profile_nav_button.svg';
  late Widget svgIconPaypalMonochromatic;
  late Widget svgIconExpenditureNavButton;
  late Widget svgIconTransactionNavButton;
  late Widget svgIconProfileNaButton;

  @override
  void initState() {
    svgIconPaypalMonochromatic = SvgPicture.asset(
      homeImage,
      color: colorPurple,
      semanticsLabel: 'home line',
      width: 20,
      height: 20,
    );
    svgIconExpenditureNavButton = SvgPicture.asset(
      expenditureNavButton,
      color: const Color.fromRGBO(152, 162, 179, 1),
      semanticsLabel: 'home line',
      width: 20,
      height: 20,
    );

    svgIconTransactionNavButton = SvgPicture.asset(
      transactionNavButton,
      color: const Color.fromRGBO(152, 162, 179, 1),
      semanticsLabel: 'home line',
      width: 20,
      height: 20,
    );
    svgIconProfileNaButton = SvgPicture.asset(
      profileNaButton,
      color: const Color.fromRGBO(152, 162, 179, 1),
      semanticsLabel: 'home line',
      width: 20,
      height: 20,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 15,right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            svgIconPaypalMonochromatic,
            svgIconExpenditureNavButton,
            svgIconTransactionNavButton,
            svgIconProfileNaButton
          ],
        ));
  }
}

class NavBarNavigation extends StatelessWidget {
  const NavBarNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String navImage = 'assets/images/navbar_image.png';
    return Container(
      color: Colors.transparent,
      height: 85,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: colorFields,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(navImage),
                  ),
                ),
                height: 55,
                child: const NavBarNavigationButton(),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: colorPurple,
                  borderRadius: BorderRadius.all(Radius.circular(
                      25.0) //                 <--- border radius here
                  ),
                ),
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }
}
