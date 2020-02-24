import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'ParkCore',
              style: Theme.of(context).textTheme.headline,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          _createMenuItem(
            context: context, icon: Icons.home, text: 'Home', route: '/home',
          ),
          _createMenuItem(
            context: context, icon: Icons.directions_car,
            text: 'Post a Parking Space', route: '/add_parking',
          ),
          _createMenuItem(
            context: context, icon: Icons.add_location,
            text: 'Find Parking', route: '/find_parking',
          ),
        ],
      ),
    );
  }
}

Widget _createMenuItem(
    {BuildContext context, IconData icon, String text, String route}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            text,
            style: Theme.of(context).textTheme.display2,
          ),
        )
      ],
    ),
    trailing: Icon(Icons.arrow_forward),
    onTap: () {
      // Update the state of the app, then close the drawer.
      //Navigator.of(context).pop();
      //Navigator.pushNamed(context, route);
      Navigator.pushReplacementNamed(context, route);
//      Navigator.pushNamedAndRemoveUntil(
//          context, route, (Route<dynamic> route) => false
//      );
    },
  );
}