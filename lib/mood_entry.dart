// Flutter code sample for

// This example shows a [Form] with one [TextFormField] and a [RaisedButton]. A
// [GlobalKey] is used here to identify the [Form] and validate input.

import 'package:my_app/fire_base_helper.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:timer_builder/timer_builder.dart';
import 'registration/authentication.dart';
import 'journal_entry.dart';
import 'date_time_helper.dart';

/// This Widget is the main application widget.
class MoodEnter extends StatelessWidget {
   MoodEnter({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  static const String _title = 'What\'s on your mind?';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: Scaffold(
        body: MyStatefulWidget(
          auth: this.auth,
          userId: this.userId,
          logoutCallback: this.logoutCallback,
        ),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final _formKey = GlobalKey<FormState>();
  
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final FireBaseHelper _fireBaseHelper = FireBaseHelper();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  DateTimeHelper _dateTimeHelper = new DateTimeHelper();

  int _counter = 0;
  int _emojiColour = -1;
 // var string[10];

  void _incrementCounter() {
    setState(() {
      _counter++;
      //TODO: insert database 
    });
  }

  @override
  void initState(){
    super.initState();
    initialiseMood();
  }

  void initialiseMood() {
      _fireBaseHelper.getMood(widget.userId, _dateTimeHelper.getCurrDateTime()).then((mood){
          setState(() {
              _emojiColour = mood;
          });
      });
  }

  updateMood(int moodtype){
    _fireBaseHelper.addMood(widget.userId, _dateTimeHelper.getCurrDateTime(), moodtype);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Row(
              children: <Widget>[

              ],
         
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 80),
                  child: new Text(
                    "Welcome to your HopeBox",
                    style: new TextStyle(fontSize: 30.0, color: Colors.black),
                  ),
                  
                )
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 0, right: 0, top: 10.0),
                    child: GestureDetector(
                      onTap: () {
                      },
                      child: new Container(
                          alignment: Alignment.center,
                          height: 60.0,
                          decoration: new BoxDecoration(
                              color: Color(0xFF18D191)),
                          child: new Text("How do you feel today?",
                              style: new TextStyle(
                                  fontSize: 20.0, color: Colors.white))),
                    ),
                  ),
                )
              ],
            ),
            new Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  new Container(
                    height: 100.0,
                    width: 60.0,
                    margin: new EdgeInsets.only(right: 300.0, top: 0.0),
                    child: new IconButton(
                          icon: new Icon(Icons.sentiment_very_dissatisfied,
                              size: 50,
                              color: (_emojiColour == 0) ? Colors.red
                              : Colors.grey,
                    ),
                          onPressed: () {
                            setState(() {
                              if(_emojiColour == 0 ){
                              _emojiColour = -1;
                              } else {
                              _emojiColour = 0;
                              _counter=0;
                              print("The value of the counter is  $_counter");
                              }
                            });
                          }
                      ),


                   ),
                  new Container(
                      height: 100.0,
                      width: 60.0,
                      margin: new EdgeInsets.only(right: 150.0, top: 0.0),
                      child: new IconButton(
                          icon: new Icon(
                            Icons.sentiment_dissatisfied,
                              size: 50,
                              color: (_emojiColour == 1) ? Colors.deepOrangeAccent
                              : Colors.grey,
                      ),
                          onPressed: () {
                            setState(() {
                              if(_emojiColour == 1) {
                                _emojiColour = -1;
                              } else {
                                _emojiColour = 1;
                                _counter=1;
                                
                              }
                            });
                            print('The value of the counter is  $_counter');
                          }
                      )
                  ),
                  new Container(
                      height: 100.0,
                      width: 60.0,
                      margin: new EdgeInsets.only(right: 0.0, top: 0.0),
                      child: new IconButton(
                          icon: new Icon(
                              Icons.sentiment_neutral,
                              size: 50,
                              color: (_emojiColour == 2) ? Colors.amber
                              : Colors.grey,
                      ),
                          onPressed: () {
                            setState(() {
                              if(_emojiColour == 2) {
                                _emojiColour = -1;
                              } else {
                                _emojiColour = 2;
                                _counter=2;
                              }
                            });
                            print('The value of the counter is  $_counter');
                          }
                      )
                  ),
                  new Container(
                      height: 100.0,
                      width: 60.0,
                      margin: new EdgeInsets.only(left: 150.0, top: 0.0),
                      child: new IconButton(
                          icon: new Icon(Icons.sentiment_satisfied, size: 50,
                            color: (_emojiColour == 3) ? Colors.greenAccent
                                : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              if(_emojiColour == 3) {
                                _emojiColour = -1;
                              } else {
                                _emojiColour = 3;
                                _counter=3;
                              }                            });
                            print('The value of the counter is  $_counter');
                          }
                      )
                  ),
                  new Container(
                      height: 100.0,
                      width: 60.0,
                      margin: new EdgeInsets.only(left: 300.0, top: 0.0),
                      child: new IconButton(
                          icon: new Icon(Icons.sentiment_very_satisfied, size: 50,
                              color: (_emojiColour == 4) ? Colors.green
                              : Colors.grey,
                      ),
                          onPressed: () {

                            setState(() {
                              if(_emojiColour == 4) {
                                _emojiColour = -1;
                              } else {
                                _emojiColour = 4;
                                _counter=4;
                              }
                            });
                            print('The value of the counter is  $_counter');
                          }
                      )
                  )
                
                ]
            ),
            new Row(
              children: <Widget>[
                Center(
                  child: RaisedButton(
                    child: new Icon(Icons.arrow_forward),
                    onPressed: (){
                      updateMood(_counter);
                      print("The $_counter is entered");
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => JournalEntry(auth: widget.auth, userId: widget.userId, logoutCallback: widget.logoutCallback)),
                      ).then((value) {
                          initialiseMood();
                      });
                    },
                  ),
                )
              ],
            )
          ],

        ),
      ),
    );

  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(

        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
            
          },
          child: Text('Go back!'),
          
        ),
      ),
    );
  }
}

_save(int mood){
  //save mood to the database 


}