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
              style: Theme.of(context).textTheme.headline2,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            title: Text(
              'Home',
              style: Theme.of(context).textTheme.headline5,
            ),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Update the state of the app.
              // ...
              // Then close the drawer.
              Navigator.pushNamed(context, '/home');
            },
          ),
          ListTile(
            title: Text(
              'Add Parking',
              style: Theme.of(context).textTheme.headline5,
            ),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Update the state of the app.
              // ...
              // Then close the drawer.
              Navigator.pushNamed(context, '/add_parking');
            },
          ),
          ListTile(
            title: Text(
              'Find Parking',
              style: Theme.of(context).textTheme.headline5,
            ),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Update the state of the app.
              // ...
              // Then close the drawer.
              Navigator.pushNamed(context, '/find_parking');
            },
          ),
        ],
      ),
    );
  }
}