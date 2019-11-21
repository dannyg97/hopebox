// Flutter code sample for

// This example shows a [Form] with one [TextFormField] and a [RaisedButton]. A
// [GlobalKey] is used here to identify the [Form] and validate input.

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'registration/authentication.dart';
//import 'package:path_provider/path_provider.dart';
import 'date_time_helper.dart';
import 'package:my_app/fire_base_helper.dart';
import 'package:my_app/sentiment_analysis_helper.dart';
import 'package:my_app/api_base_helper.dart';
import 'package:http/http.dart';

// void main() => runApp(JournalEntry());

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
  JournalEntry({Key key, this.auth, this.userId, this.logoutCallback, this.isSentimentAnalysisEnabled})
      : super(key: key);

  final BaseAuth auth;
  final String userId;
  final VoidCallback logoutCallback;
  final bool isSentimentAnalysisEnabled;
  static const String _title = 'What\'s on your mind?'; 
  final FireBaseHelper _fireBaseHelper = FireBaseHelper();

  bool debugShowCheckedModeBanner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("$_title"),
      // ),
      body: Stack(
        children: <Widget>[
          MyStatefulWidget(auth: this.auth, userId: this.userId, logoutCallback: this.logoutCallback, isSentimentAnalysisEnabled: this.isSentimentAnalysisEnabled,),
        ],
      )
    );
  }
}




class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key, this.auth, this.userId, this.logoutCallback, this.isSentimentAnalysisEnabled})
      : super(key: key);
  final BaseAuth auth;
  final String userId;
  final VoidCallback logoutCallback;
  bool isSentimentAnalysisEnabled;

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
//  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();
  final FireBaseHelper _fireBaseHelper = FireBaseHelper();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTimeHelper _dateTimeHelper = new DateTimeHelper();
  SentimentAnalysisHelper _sentimentAnalysisHelper = SentimentAnalysisHelper(ApiBaseHelper(Client()));
  Query _todoQuery;
  bool _isEnabled;
  String _journalEntry;

  @override
  void initState(){
    super.initState();
    initialiseJournalEntry();
    myController.addListener(_updateDoneIconEnabledState);
    _isEnabled = true;

  }

    void initialiseJournalEntry() {
      _fireBaseHelper.getJournalEntry(widget.userId, _dateTimeHelper.getCurrDateTime()).then((journalEntry){
          setState(() {
              _journalEntry = journalEntry;
              myController.text = _journalEntry;
          });
      });
  }

  _updateDoneIconEnabledState() {
    setState(() {
      print("setting state");
      _isEnabled = myController.text.isNotEmpty ? true : false;
    });
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  updateJournalEntry(String journal){
    _fireBaseHelper.addJournalEntry(widget.userId, _dateTimeHelper.getCurrDateTime(), journal.toString());
    if (widget.isSentimentAnalysisEnabled)
      _sentimentAnalysisHelper.analyseTextSentiment(journal.toString()).then((score) {
        _fireBaseHelper.addMood(widget.userId, _dateTimeHelper.getCurrDateTime(), score);
      });
    }

  getIsEnabled() {
    return _isEnabled;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
            title: const Text("What's on your mind?"),
            // backgroundColor: const Color(0xFFFADA5E),
            // leading: new IconButton(icon: new Icon(Icons.arrow_back)),
            actions: [new IconButton(icon: new Icon(Icons.done),
                onPressed: _isEnabled ? () {
                  var input = myController.text;
                  myController.clear();
                  updateJournalEntry(input.toString());
                  Navigator.pop(context);
                } : null)
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
            ],
          ),
        ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          var input = myController.text;
          myController.clear();
          updateJournalEntry(input.toString());
          Navigator.pop(context);
        },
        label: Text('Submit'),
        icon: Icon(Icons.thumb_up),
        backgroundColor: Colors.lightGreen,
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



