import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parkcore_app/parking/find_parking.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: SvgPicture.asset(
              'assets/ParkCore_WHITE_SQUIRREL.svg',
              fit: BoxFit.contain,
              semanticsLabel: 'ParkCore Logo',
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
            ),
          ),
          CreateMenuItem(
            myKey: Key('homeKey'),
            context: context,
            icon: Icons.home,
            text: 'Home',
            route: '/home',
          ),
          CreateMenuItem(
            myKey: Key('addParking1Key'),
            context: context,
            icon: Icons.directions_car,
            text: 'Post a Parking Space',
            route: '/add_parking1',
          ),
          DefaultMap(context),
          CreateMenuItem(
            myKey: Key('contactKey'),
            context: context,
            icon: Icons.contacts,
            text: 'Contact Us',
            route: '/contact',
          ),
          CreateMenuItem(
            myKey: Key('aboutKey'),
            context: context,
            icon: Icons.sentiment_satisfied,
            text: 'About ParkCore',
            route: '/about',
          ),
        ],
      ),
    );
  }
}

Widget CreateMenuItem(
    {Key myKey, BuildContext context, IconData icon, String text, String route}) {
  return ListTile(
    //key: Key('menuItem'),
    key: myKey,
    title: Row(
      children: <Widget>[
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Icon(
            icon,
            color: Color(0xFF4D2C91),
          ),
        ),
        Flexible(
          flex: 3,
          fit: FlexFit.tight,
          child:Padding(
            padding: EdgeInsets.only(left: 3.0),
            child: Text(
              text,
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
        ),
      ],
    ),
    trailing: Icon(
      Icons.arrow_forward,
      color: Theme.of(context).accentColor,
    ),
    onTap: () {
      // Update the state of the app, then close the drawer.
      Navigator.pushReplacementNamed(context, route);
    },
  );
}

Widget DefaultMap(BuildContext context) {
  return ListTile(
    key: Key('menuMap'),
    title: Row(
      children: <Widget>[
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Icon(
            Icons.location_on,
            color: Color(0xFF4D2C91),
          ),
        ),
        Flexible(
          flex: 3,
          fit: FlexFit.tight,
          child: Padding(
            padding: EdgeInsets.only(left: 3.0),
            child: Text(
              'Visit Our Hometown!',
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
        ),
      ],
    ),
    trailing: Icon(
      Icons.arrow_forward,
      color: Theme.of(context).accentColor,
    ),
    onTap: () {
      // Update the state of the app, then close the drawer.
      //Navigator.pushReplacementNamed(context, );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FindParking(
            colRef: Firestore.instance.collection('parkingSpaces'),
            title: 'Find Parking',
            city: 'Chico',
            latlong: '{39.7285,-121.8375}',
          ),
        ),
      );
    },
  );
}
