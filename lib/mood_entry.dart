// Flutter code sample for

// This example shows a [Form] with one [TextFormField] and a [RaisedButton]. A
// [GlobalKey] is used here to identify the [Form] and validate input.

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:timer_builder/timer_builder.dart';
import 'registration/authentication.dart';
import "datasets/mood.dart";
import 'journal_entry.dart';

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
      title: _title,
      home: Scaffold(
        
        // appBar: new AppBar(
        //     // title: const Text(_title),
        //     backgroundColor: const Color(0xFF18D191),
        //     actions: [new IconButton(icon: new Icon(Icons.arrow_back),
        //         onPressed: () {
        //           // Navigate to second route when tapped.
        //           Navigator.pop(context);
        //         })
        //     ]
        // ),
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
  final GlobalKey<FormState> formKey = GlobalKey<FormState>(); 

  Query _moodEntry; 


  int _counter = 0;
  int _emojiColour = 0;
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
    _moodEntry = _database.reference().child('mood_entry').orderByChild('userId').equalTo(widget.userId);
  }

  addNewMood(int moodtype){
    print(moodtype);
    var _userid = widget.userId;
    Mood mood = new Mood(moodtype.toString(), widget.userId, true);
    print("The mood type is and userid is $_userid");
    _database.reference().child("mood_entry").push().set(mood.toJson());
  }

  updateMood(Mood mood){
    mood.completed = !mood.completed;
    if(mood!=null){
      _database.reference().child('mood').child(mood.key).set(mood.toJson());
    }
  }

  deleteMood(String moodId, int index){
    _database.reference().child('mood').child(moodId).remove();
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
                          child: new Text("How are you feeling ? ",
                              style: new TextStyle(
                                  fontSize: 20.0, color: Colors.white))),
                    ),
                  ),
                )
              ],
            ),
             new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              
              children: <Widget>[
                Center(
                  child: new Text(        
                    "You are felling $_counter",
                  )
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
                              color: (_emojiColour == 1) ? Colors.red
                              : Colors.grey,
                    ),
                          onPressed: () {
                            setState(() {
                              if(_emojiColour == 1 ){
                              _emojiColour = 0;
                              } else {
                              _emojiColour = 1;
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
                              color: (_emojiColour == 2) ? Colors.deepOrangeAccent
                              : Colors.grey,
                      ),
                          onPressed: () {
                            setState(() {
                              if(_emojiColour == 2) {
                                _emojiColour = 0;
                              } else {
                                _emojiColour = 2;
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
                              color: (_emojiColour == 3) ? Colors.amber
                              : Colors.grey,
                      ),
                          onPressed: () {
                            setState(() {
                              if(_emojiColour == 3) {
                                _emojiColour = 0;
                              } else {
                                _emojiColour = 3;
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
                            color: (_emojiColour == 4) ? Colors.greenAccent
                                : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              if(_emojiColour == 4) {
                                _emojiColour = 0;
                              } else {
                                _emojiColour = 4;
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
                              color: (_emojiColour == 5) ? Colors.green
                              : Colors.grey,
                      ),
                          onPressed: () {

                            setState(() {
                              if(_emojiColour == 5) {
                                _emojiColour = 0;
                              } else {
                                _emojiColour = 5;
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
                      addNewMood(_counter);
                      print("The $_counter is entered");
                      Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => JournalEntry(auth: widget.auth, userId: widget.userId, logoutCallback: widget.logoutCallback)),
            );
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