import 'package:flutter/material.dart';
import 'registration/authentication.dart';
import 'Start/root_page.dart';

class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color startGradient = new Color(0xffFCE691);
    Color endGradient = new Color(0xffFF7E7E);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              // Where the linear gradient begins and ends
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              // Add one stop for each color. Stops should increase from 0 to 1
              stops: [0, 1],
              colors: [startGradient, endGradient],
            )),
            child: Padding(
              padding: EdgeInsets.all(23),
              child: ListView(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 100, 0, 20),
                      child: Center(
                          child: Text(
                        'hopebox',
                        style: TextStyle(
                          color: Color(0xffFFF4CE),
                          fontSize: 75,
                          fontFamily: 'Pacifico',
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(0.0, 4.0),
                              blurRadius: 3.0,
                              color: Color(0x20000000),
                            ),
                            Shadow(
                              offset: Offset(0, 4.0),
                              blurRadius: 8.0,
                              color: Color(0x20000000),
                            ),
                          ],
                        ),
                      ))),
                  Padding(
                    padding: EdgeInsets.only(top: 165),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    RootPage(auth: new Auth(), login: false)));
                      },
                      child: Text(
                        'LET\'S START!',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      color: Color(0xffff2d55),
                      elevation: 0,
                      minWidth: 400,
                      height: 50,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Center(
                        child: new GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    RootPage(auth: new Auth(), login: true)));
                      },
                      child: new Text(
                        'I ALREADY HAVE AN ACCOUNT',
                        style: TextStyle(
                            fontFamily: 'Arial',
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}