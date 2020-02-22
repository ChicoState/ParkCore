import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            title: Text('Home'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Update the state of the app.
              // ...
              // Then close the drawer.
              Navigator.pushNamed(context, '/home');
              //Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Add Parking'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Update the state of the app.
              // ...
              // Then close the drawer.
              Navigator.pushNamed(context, '/add_parking');
              //Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Find Parking'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Update the state of the app.
              // ...
              // Then close the drawer.
              Navigator.pushNamed(context, '/find_parking');
              // Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}