import 'package:flutter/material.dart';
import 'package:my_app/landing_page.dart';

void main() => runApp(MoodEntry());


class MoodEntry extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,

      ),
      home: MoodEntryState(title: 'Mood Entry'),
    );
  }
}

class MoodEntryState extends StatefulWidget {
  MoodEntryState({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MoodEntryState> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center (
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
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => LandingPage(),
                ));

              },
              tooltip: 'Increase volume by 1',

            ),
            IconButton(
              icon: Icon(Icons.sentiment_dissatisfied),
              color: Colors.orange,
              onPressed: () {
                print('The value of the counter is  $_counter');
                setState(() {
                  _counter+=1;

                });
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => LandingPage(),
                ));

              },
            ),
            IconButton(
              icon: Icon(Icons.sentiment_neutral),
              color: Colors.amber,
              onPressed: () {
                print('The value of the counter is  $_counter');
                setState(() {
                  _counter+=2;
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => LandingPage(),
                  ));

                });
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => LandingPage(),
                ));

              },
            ),
            IconButton(
              icon: Icon(Icons.sentiment_satisfied),
              color: Colors.greenAccent,
              onPressed: () {
                print('The value of the counter is  $_counter');
                setState(() {
                  _counter+=3;
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => LandingPage(),
                  ));

                });
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => LandingPage(),
                ));

              },
            ),
            IconButton(
              icon: Icon(Icons.sentiment_very_satisfied),
              color: Colors.green,
              onPressed: () {
                setState(() {
                  print('The value of the counter is  $_counter');

                  _counter+=5;
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => LandingPage(),
                  ));

                });
              },
            ),
          ],
        ),

      ),


      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Route'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Open route'),
          onPressed: () {
            // Navigate to second route when tapped.
            Navigator.pop(context);


          },
        ),
      ),
    );
  }
}
