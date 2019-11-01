// Flutter code sample for

// This example shows a [Form] with one [TextFormField] and a [RaisedButton]. A
// [GlobalKey] is used here to identify the [Form] and validate input.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:path_provider/path_provider.dart';
import 'dart:io';

void main() => runApp(JournalEntry());

/*

 TODO:
 Test the functionality of:
   [DONE] Writing anything should 'echo' inside the textbox
   [DONE] Tapping the save button should: save and erase what is currently on the screen

 Ideally:
  Have a basic journal entry page that lists all entries (O.K. if just one)
  [column]
  |-[curved square]
      |-[text]
 */
/// This Widget is the main application widget.
class JournalEntry extends StatelessWidget {
  static const String _title = 'What\'s on your mind?';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      debugShowCheckedModeBanner: false,
      home: MyStatefulWidget()
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
//  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
            title: const Text("What's on your mind?"),
            backgroundColor: const Color(0xFFFADA5E),
            leading: new IconButton(icon: new Icon(Icons.arrow_back)),

            actions: [new IconButton(icon: new Icon(Icons.done),
                onPressed: () {
                  var input = myController.text;
                  myController.clear();
                  _save(input);
                  return showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                            content: Text(input)
                        );
                      }
                  );
                })
            ]
        ),
        body: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  focusNode: FocusNode(),
                  controller: myController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  decoration: InputDecoration.collapsed(
                    hintText: 'Write about your day',
                    hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                    border: InputBorder.none,
                  ),
                ),
              ),
              /*
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RaisedButton(
                    onPressed: () {
                      // Validate will return true if the form is valid, or false if
                      // the form is invalid.
                      if (_formKey.currentState.validate()) {
                        // Process data.
                        print(_formKey.toString());
                      }
                    },
                    child: Text('Submit'),
                  ),
                ),

         */
            ],
          ),
        ));
  }
}


//_read() async {
//  try {
//    final directory = await getApplicationDocumentsDirectory();
//    final file = File('${directory.path}/my_file.txt');
//    String text = await file.readAsString();
//    print(text);
//  } catch (e) {
//    print("Couldn't read file");
//  }
//}

_save(var input) async {
  //final directory = await getApplicationDocumentsDirectory();
  //final file = File('${directory.path}/my_file.txt');
  //final text = input;
  //await file.writeAsString(text);
  //print(directory);
  //print('File has been saved');
}


