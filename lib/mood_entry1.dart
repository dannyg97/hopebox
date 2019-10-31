// Flutter code sample for

// This example shows a [Form] with one [TextFormField] and a [RaisedButton]. A
// [GlobalKey] is used here to identify the [Form] and validate input.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './journal_entry.dart';

void main() => runApp(MoodEnter());

/// This Widget is the main application widget.
class MoodEnter extends StatelessWidget {
  static const String _title = 'What\'s on your mind?';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: new AppBar(
            title: const Text(_title),
            backgroundColor: const Color(0xFF18D191),
            leading: new IconButton(icon: new Icon(Icons.arrow_back)),
            actions: [new IconButton(icon: new Icon(Icons.done),
                onPressed: () {
                  // Navigate to second route when tapped.
                  Navigator.pop(context);
                })
            ]
        ),
        body: MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final _formKey = GlobalKey<FormState>();

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 80.0),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MoodEnter()),
                        );
                      },
                      child: new Container(
                          alignment: Alignment.center,
                          height: 60.0,
                          decoration: new BoxDecoration(
                              color: Color(0xFF18D191)),
                          child: new Text("How are you feeling today",
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
                          icon: new Icon(Icons.sentiment_very_dissatisfied, color: Colors.red,size: 50),
                          onPressed: () {
                            _counter+=0;
                            print('The value of the counter is  $_counter');
                          }
                      ),


                   ),
                  new Container(
                      height: 100.0,
                      width: 60.0,
                      margin: new EdgeInsets.only(right: 150.0, top: 0.0),

                      child: new IconButton(
                          icon: new Icon(Icons.sentiment_dissatisfied, color: Colors.redAccent,size: 50),
                          onPressed: () {
                            _counter+=1;
                            print('The value of the counter is  $_counter');
                          }
                      )
                  ),
                  new Container(
                      height: 100.0,
                      width: 60.0,
                      margin: new EdgeInsets.only(right: 0.0, top: 0.0),
                      child: new IconButton(
                          icon: new Icon(Icons.sentiment_neutral, color: Colors.amber,size: 50),
                          onPressed: () {
                            _counter+=1;
                            print('The value of the counter is  $_counter');
                          }
                      )
                  ),
                  new Container(
                      height: 100.0,
                      width: 60.0,
                      margin: new EdgeInsets.only(left: 150.0, top: 0.0),
                      child: new IconButton(
                          icon: new Icon(Icons.sentiment_satisfied, color: Colors.teal, size: 50),
                          onPressed: () {
                            _counter+=1;
                            print('The value of the counter is  $_counter');
                          }
                      )
                  ),
                  new Container(
                      height: 100.0,
                      width: 60.0,
                      margin: new EdgeInsets.only(left: 300.0, top: 0.0),
                      child: new IconButton(
                          icon: new Icon(Icons.sentiment_very_satisfied, color: Colors.green,size: 50),
                          onPressed: () {
                            _counter+=1;
                            print('The value of the counter is  $_counter');
                          }
                      )
                  )

                ]


            )


          ],
        ),
      ),
    );

    /*Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:

          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.sentiment_very_dissatisfied),
                color: Colors.red,
                onPressed: () {
                  print('The value of the counter is  $_counter');
                  setState(() {
                  });
                },
                tooltip: 'Increase volume by 1',

              ),
              IconButton(
                icon: Icon(Icons.sentiment_dissatisfied),
                color: Colors.orange,
                onPressed: () {
                  _counter+=1;
                  print('The value of the counter is  $_counter');
                  setState(() {
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.sentiment_neutral),
                color: Colors.amber,
                onPressed: () {
                  setState(() {
                    _counter+=2;
                    print('The value of the counter is  $_counter');
                  });

                },
              ),
              IconButton(
                icon: Icon(Icons.sentiment_satisfied),
                color: Colors.greenAccent,
                onPressed: () {
                  setState(() {
                    _counter+=3;
                    print('The value of the counter is  $_counter');
                  });

                },
              ),
              IconButton(
                icon: Icon(Icons.sentiment_very_satisfied),
                color: Colors.green,
                onPressed: () {
                  setState(() {
                    _counter+=4;
                    print('The value of the counter is  $_counter');
                  });

                },
              ),
            ],
          ),

      ),

    );
  }*/
  }
}