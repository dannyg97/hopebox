// Flutter code sample for

// This example shows a [Form] with one [TextFormField] and a [RaisedButton]. A
// [GlobalKey] is used here to identify the [Form] and validate input.

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/registration/authentication.dart';
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
  JournalEntry({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final String userId;
  final VoidCallback logoutCallback;
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
          MyStatefulWidget(auth: this.auth, userId: this.userId, logoutCallback: this.logoutCallback,),
        ],
      )
    );
  }
}




class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);
  final BaseAuth auth;
  final String userId;
  final VoidCallback logoutCallback;

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

  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  updateJournalEntry(String journal){
    if(journal.length>0) {
      _fireBaseHelper.addJournalEntry(widget.userId, _dateTimeHelper.getCurrDateTime(), journal.toString());
      _sentimentAnalysisHelper.analyseTextSentiment(journal.toString()).then((score) {
        print("score is $score");
        _fireBaseHelper.addMood(widget.userId, _dateTimeHelper.getCurrDateTime(), score);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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




// class _JournalEntryPageState extends State<HomePage>{

//   final FirebaseDatabase _database = FirebaseDatabase.instance; 
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>(); 

//   Query _todoQuery; 

//   @override 
//   void initState(){
//     super.initState(); 

//     _todoQuery = _database.reference().child('journal_entry')
//     .orderByChild('userId').equalTo(widget.userId);

//   }

//   addNewJournal(String journal){
//     if(journal.length>0){
//       Journal journalRecord = new Journal(journal.toString(), widget.userId, true);
//       _database.reference().child("journal_entry").push().set(journalRecord.toJson());
//     }
//   }

//   updateNewJournal(){

//   }

//   deleteJournal(){

//   }

  
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return null;
//   }

// }

