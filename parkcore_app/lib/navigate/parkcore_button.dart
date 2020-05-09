import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogoButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: Key('logoButton'),
      icon: SvgPicture.asset(
        'assets/ParkCore_WHITE_SQUIRREL_ONLY.svg',
        fit: BoxFit.fitWidth,
        semanticsLabel: 'ParkCore Logo',
      ),
      onPressed: () {
        Navigator.pushReplacementNamed(context, '/home');
      },
    );
  }
}
