import 'package:flutter/material.dart';

class ParkCoreText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'ParkCore',
          style: Theme.of(context).textTheme.headline,
        ),
        Text(
          'find a spot. go nuts.',
          style: Theme.of(context).textTheme.display1,
        ),
        SizedBox(height: 10),
        Container(
          margin: const EdgeInsets.all(20.0),
          padding: const EdgeInsets.all(20.0),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(width: 2.0, color: Color(0xFF99F1B8)),
              left: BorderSide(width: 2.0, color: Color(0xFF99F1B8)),
              right: BorderSide(width: 2.0, color: Color(0xFF358D5B)),
              bottom: BorderSide(width: 2.0, color: Color(0xFF358D5B)),
            ),
          ),
          child: Text(
            'ParkCore is a parking application that allows local property '
            'owners around the Chico State campus to earn a little money '
            'through the rental of their driveway to students, faculty, '
            'and staff.',
            style: Theme.of(context).textTheme.display2,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
