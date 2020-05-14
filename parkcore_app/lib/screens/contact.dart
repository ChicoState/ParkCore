import 'package:flutter/material.dart';
import 'package:parkcore_app/navigate/menu_drawer.dart';
import 'package:parkcore_app/navigate/parkcore_button.dart';

class ContactUs extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Contact Us'),
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        actions: <Widget>[
          LogoButton(),
        ],
      ),
      drawer: MenuDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10.0),
            ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.asset(
                'assets/parkcore_logo_green2.jpg',
                height: 150,
                fit:BoxFit.fill,
              ),
            ),
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
                'Contact ParkCore',
                style: Theme.of(context).textTheme.display2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}