// Flutter code sample for

// This example shows a [Form] with one [TextFormField] and a [RaisedButton]. A
// [GlobalKey] is used here to identify the [Form] and validate input.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(JournalEntry());

/// This Widget is the main application widget.
class JournalEntry extends StatelessWidget {
  static const String _title = 'What\'s on your mind?';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: new AppBar(
          title: const Text(_title),
          backgroundColor: const Color(0xFFFADA5E),
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          Padding(
          padding: const EdgeInsets.all(16.0),
            child: TextField(
              focusNode: FocusNode(),
              controller: TextEditingController(),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              decoration: InputDecoration.collapsed(
                hintText: 'Start typing...',
                hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
                border: InputBorder.none,
              ),
            ),
          ),
//          Padding(
//            padding: const EdgeInsets.all(16.0),
//            child: RaisedButton(
//              onPressed: () {
//                // Validate will return true if the form is valid, or false if
//                // the form is invalid.
//                if (_formKey.currentState.validate()) {
//                  // Process data.
//                }
//              },
//              child: Text('Submit'),
//            ),
//          ),
        ],
      ),
    );
  }
}