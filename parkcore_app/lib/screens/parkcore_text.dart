import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ParkCoreText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'PARKCORE',
          style: Theme.of(context).textTheme.headline1,
        ),
        Text(
          'find a spot. go nuts.',
          style: Theme.of(context).textTheme.headline2,
        ),
        SizedBox(height: 10),
        Container(
          margin: EdgeInsets.all(10),
          width: 250,
          height: 250,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: Container(
              padding: EdgeInsets.all(30),
              child: SvgPicture.asset(
                'assets/ParkCore_WHITE_SQUIRREL.svg',
                fit: BoxFit.fitWidth,
                semanticsLabel: 'ParkCore Logo',
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
