import 'package:flutter/material.dart';
import 'package:parkcore_app/navigate/menu_drawer.dart';
import 'package:parkcore_app/navigate/parkcore_button.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class About extends StatefulWidget {
  About({Key key}) : super(key: key);

  @override
  _MyAboutState createState() => _MyAboutState();
}

class _MyAboutState extends State<About>{
  String about_us = "";
  String about_us_short = "";

  Future<String> loadAboutUs() async {
    var about_us_text = await rootBundle.loadString('assets/text/about_us.txt');
    return about_us_text;
  }

  Future<String> loadAboutUsShort() async {
    var about_us_short = await rootBundle.loadString('assets/text/about_us_short.txt');
    return about_us_short;
  }

  void getText() async {
    String text = await loadAboutUs();
    String text_short = await loadAboutUsShort();
    setState(() {
      about_us = text;
      about_us_short = text_short;
    });
  }

  @override
  void initState() {
    super.initState();
    getText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('About ParkCore'),
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        actions: <Widget>[
          LogoButton(),
        ],
      ),
      drawer: MenuDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
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
                padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 5.0),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 2.0, color: Color(0xFF99F1B8)),
                    left: BorderSide(width: 1.0, color: Color(0xFF99F1B8)),
                    right: BorderSide(width: 1.0, color: Color(0xFF358D5B)),
                    bottom: BorderSide(width: 2.0, color: Color(0xFF358D5B)),
                  ),
                ),
                child: Text(
                  about_us_short,
                  style: Theme.of(context).textTheme.display2,
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      about_us,
                      style: Theme.of(context).textTheme.display2,
                      textAlign: TextAlign.left,
                    )
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Container(
                  padding: EdgeInsets.all(20),
                  width: 300.0,
                  child: Image.asset(
                    'assets/Acorns_White.png',
                    fit: BoxFit.fitWidth,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
