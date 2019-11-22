// Flutter code sample for

// This example shows a [Form] with one [TextFormField] and a [RaisedButton]. A
// [GlobalKey] is used here to identify the [Form] and validate input.

import 'package:my_app/fire_base_helper.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/entry_instance.dart';
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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

  final _moods = [
    '',
    'awful.',
    'a bit on the bad side.',
    'neutral.',
    'happy!',
    'ecstatic!',
  ];

  DateTimeHelper _dateTimeHelper = new DateTimeHelper();

  // Make emoji colour start from 0 instead of 1
  int _emojiColour = 0;
  List<EntryInstance> _entryInstances;
  bool _isSentimentAnalysisEnabled = false;

  @override
  void initState() {
    super.initState();
    initialiseMood();
    initialiseSentimentAnalysisOptIn();
    initialiseEntryInstances();
  }

  void initialiseMood() {
    _fireBaseHelper
        .getMood(widget.userId, _dateTimeHelper.getCurrDateTime())
        .then((mood) {
      setState(() {
        _emojiColour = mood;
      });
    });
  }

  updateMood(int moodtype) {
    _fireBaseHelper.addMood(
        widget.userId, _dateTimeHelper.getCurrDateTime(), moodtype);
  }

  void initialiseSentimentAnalysisOptIn() {
    _fireBaseHelper
        .getIsSentimentAnalysisEnabled(widget.userId)
        .then((isSentimentAnalysisEnabled) {
      setState(() {
        _isSentimentAnalysisEnabled = isSentimentAnalysisEnabled;
      });
    });
  }

  void initialiseEntryInstances() {
    _fireBaseHelper
        .getAllUserEntryInstances(widget.userId)
        .then((entryInstances) {
      setState(() {
        _entryInstances = entryInstances;
      });
    });
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          key: new Key('alert_dialog'),
          title: new Text("Sentiment Analysis Enabled"),
          content: new Text(
              "You've enabled our journal entry sentiment analysis feature, so your moods are being automatically detected.\n\nIn order to disable this feature, please toggle the feature off."),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
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
                colors: [Color(0xffFCE691), Color(0xffFF7E7E)],
              ),
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Row(
                    children: <Widget>[],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 0, right: 0, top: 10.0),
                          child: GestureDetector(
                            onTap: () {},
                            child: new Container(
                              alignment: Alignment.center,
                              height: 60.0,
                              child: new Text(
                                "How are you feeling today?",
                                style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  new Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      "I'm feeling... ${_moods[_emojiColour]}",
                      style: new TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  new Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      new Container(
                        height: 100.0,
                        width: 60.0,
                        margin: new EdgeInsets.only(right: 250.0, top: 0.0),
                        child: new IconButton(
                            key: new Key('very_dissatisfied'),
                            icon: new Icon(
                              Icons.sentiment_very_dissatisfied,
                              size: 50,
                              color: (_emojiColour == 1)
                                  ? Colors.red
                                  : Colors.white,
                            ),
                            onPressed: () {
                              if (_isSentimentAnalysisEnabled) {
                                _showDialog();
                              } else {
                                setState(() {
                                  if (_emojiColour == 1) {
                                    _emojiColour = 0;
                                  } else {
                                    _emojiColour = 1;
                                  }
                                });
                              }
                            }),
                      ),
                      new Container(
                          height: 100.0,
                          width: 60.0,
                          margin: new EdgeInsets.only(right: 125.0, top: 0.0),
                          child: new IconButton(
                              key: new Key('dissatisfied'),
                              icon: new Icon(
                                Icons.sentiment_dissatisfied,
                                size: 50,
                                color: (_emojiColour == 2)
                                    ? Colors.deepOrangeAccent
                                    : Colors.white,
                              ),
                              onPressed: () {
                                if (_isSentimentAnalysisEnabled) {
                                  _showDialog();
                                } else {
                                  setState(() {
                                    if (_emojiColour == 2) {
                                      _emojiColour = 0;
                                    } else {
                                      _emojiColour = 2;
                                    }
                                  });
                                }
                              })),
                      new Container(
                        height: 100.0,
                        width: 60.0,
                        margin: new EdgeInsets.only(right: 0.0, top: 0.0),
                        child: new IconButton(
                          key: new Key('neutral'),
                          icon: new Icon(
                            Icons.sentiment_neutral,
                            size: 50,
                            color: (_emojiColour == 3)
                                ? Colors.yellowAccent
                                : Colors.white,
                          ),
                          onPressed: () {
                            if (_isSentimentAnalysisEnabled) {
                              _showDialog();
                            } else {
                              setState(
                                () {
                                  if (_emojiColour == 3) {
                                    _emojiColour = 0;
                                  } else {
                                    _emojiColour = 3;
                                  }
                                },
                              );
                            }
                          },
                        ),
                      ),
                      new Container(
                        height: 100.0,
                        width: 60.0,
                        margin: new EdgeInsets.only(left: 125.0, top: 0.0),
                        child: new IconButton(
                          key: new Key('satisfied'),
                          icon: new Icon(
                            Icons.sentiment_satisfied,
                            size: 50,
                            color: (_emojiColour == 4)
                                ? Colors.lightGreenAccent
                                : Colors.white,
                          ),
                          onPressed: () {
                            if (_isSentimentAnalysisEnabled) {
                              _showDialog();
                            } else {
                              setState(() {
                                if (_emojiColour == 4) {
                                  _emojiColour = 0;
                                } else {
                                  _emojiColour = 4;
                                }
                              });
                            }
                          },
                        ),
                      ),
                      new Container(
                          height: 100.0,
                          width: 60.0,
                          margin: new EdgeInsets.only(left: 250.0, top: 0.0),
                          child: new IconButton(
                              key: new Key('very_satisfied'),
                              icon: new Icon(
                                Icons.sentiment_very_satisfied,
                                size: 50,
                                color: (_emojiColour == 5)
                                    ? Colors.greenAccent
                                    : Colors.white,
                              ),
                              onPressed: () {
                                if (_isSentimentAnalysisEnabled) {
                                  _showDialog();
                                } else {
                                  setState(() {
                                    if (_emojiColour == 5) {
                                      _emojiColour = 0;
                                    } else {
                                      _emojiColour = 5;
                                    }
                                  });
                                }
                              })),
                    ],
                  ),
                  new RaisedButton(
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red)),
                    child: new Icon(Icons.arrow_forward, color: Colors.white),
                    onPressed: () {
                      updateMood(_emojiColour);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JournalEntry(
                              auth: widget.auth,
                              userId: widget.userId,
                              logoutCallback: widget.logoutCallback,
                              isSentimentAnalysisEnabled:
                                  _isSentimentAnalysisEnabled),
                        ),
                      ).then(
                        (value) {
                          initialiseMood();
                        },
                      );
                    },
                  ),
                  new Row(
                    children: <Widget>[
                      new Flexible(
                        child: new SwitchListTile(
                          key: new Key('sentiment_analysis_switch'),
                          value: _isSentimentAnalysisEnabled,
                          title: const Text(
                            'Journal Entry Sentiment Analysis',
                            style: TextStyle(color: Colors.white),
                          ),
                          onChanged: (value) {
                            _fireBaseHelper.addSentimentAnalysisOptInStatus(
                                widget.userId, value);
                            setState(
                              () {
                                _isSentimentAnalysisEnabled = value;
                              },
                            );
                          },
                          secondary: const Icon(Icons.lightbulb_outline, color: Colors.white),
                          activeColor: Color(0xffff2d55),
                        ),
                      ),
                    ],
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

_save(int mood) {
  //save mood to the database
}
