import 'package:flutter/material.dart';
import 'package:my_app/journal_entry.dart';
import '../registration/authentication.dart';
import 'package:firebase_database/firebase_database.dart';

class AnalysisPage extends StatelessWidget {
  AnalysisPage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  // Query _journalQuery;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Text("UserId: $userId"),
          Padding(
            
          ),
          // Text("Hello World")
          AnalysisWidget(auth: this.auth, userId: this.userId, logoutCallback: this.logoutCallback),
        ],
      ),
    );
  }
}

class AnalysisWidget extends StatefulWidget{
  AnalysisWidget({Key key,this.auth, this.userId, this.logoutCallback})
      : super(key: key);
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  @override
  State<StatefulWidget> createState() => _AnalysisWidgetState(); 
}

class _AnalysisWidgetState extends State<AnalysisWidget>{
  final FirebaseDatabase _database = FirebaseDatabase.instance; 
  final GlobalKey<FormState> formKey = GlobalKey<FormState>(); 
  Query _journaleQuery; 
  @override 
  void initState(){
    super.initState();
    _journaleQuery = _database.reference().child('journal_entry')
    .orderByChild('userId').equalTo(widget.userId);
  }
  // _journaelQuery
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        Text("Hello User: $_journaleQuery")
      ],
    );
  }
  
}
