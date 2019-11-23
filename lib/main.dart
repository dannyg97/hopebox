import 'package:flutter/material.dart';
//import 'registration/authentication.dart';
//import 'Start/root_page.dart';
import './calendar.dart';


import 'Start.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Start(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/*

  OLD (FOR REFERENCE):

  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'HopeBox Login',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new RootPage(auth: new Auth()));
  }

 */