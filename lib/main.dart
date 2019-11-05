import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'authentication.dart';
import 'root_page.dart';
=======
import './landing_page.dart';
>>>>>>> mood_entry

void main() {
  runApp(new MaterialApp(
    home: new LandingPage(),
  ));
}

/*void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return new MaterialApp(
        title: 'HopeBox Login',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new RootPage(auth: new Auth()));
=======
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.amber,
      ),
      home: MyHomePage(title: 'Mood Entry'),
    );
>>>>>>> mood_entry
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body:
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.sentiment_very_dissatisfied),
            color: Colors.red,
            onPressed: () {
              print('The value of the counter is  $_counter');
              setState(() {
                _counter++;
              });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondRoute()),
              );

            },
            tooltip: 'Increase volume by 1',

          ),
          IconButton(
            icon: Icon(Icons.sentiment_dissatisfied),
            color: Colors.orange,
            onPressed: () {
              print('The value of the counter is  $_counter');
              setState(() {
                _counter+=2;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.sentiment_neutral),
            color: Colors.amber,
            onPressed: () {
              print('The value of the counter is  $_counter');
              setState(() {
                _counter+=3;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.sentiment_satisfied),
            color: Colors.greenAccent,
            onPressed: () {
              print('The value of the counter is  $_counter');
              setState(() {
                _counter+=4;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.sentiment_very_satisfied),
            color: Colors.green,
            onPressed: () {
              setState(() {
                print('The value of the counter is  $_counter');

                _counter+=5;
              });
            },
          ),
        ],
      ),

      /*Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),*/
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
}*/
