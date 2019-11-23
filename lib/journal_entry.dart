import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'registration/authentication.dart';
import 'package:my_app/fire_base_helper.dart';
import 'package:my_app/sentiment_analysis_helper.dart';
import 'package:my_app/api_base_helper.dart';
import 'package:http/http.dart';
import 'date_time_helper.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

/// This Widget is the main application widget.
class JournalEntry extends StatelessWidget {
  JournalEntry(
      {Key key,
      this.auth,
      this.userId,
      this.logoutCallback,
      this.isSentimentAnalysisEnabled})
      : super(key: key);

  final BaseAuth auth;
  final String userId;
  final VoidCallback logoutCallback;
  final bool isSentimentAnalysisEnabled;
  final FireBaseHelper _fireBaseHelper = FireBaseHelper();

  final bool debugShowCheckedModeBanner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          MyStatefulWidget(
            auth: this.auth,
            userId: this.userId,
            logoutCallback: this.logoutCallback,
            isSentimentAnalysisEnabled: this.isSentimentAnalysisEnabled,
          ),
        ],
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget(
      {Key key,
      this.auth,
      this.userId,
      this.logoutCallback,
      this.isSentimentAnalysisEnabled})
      : super(key: key);
  final BaseAuth auth;
  final String userId;
  final VoidCallback logoutCallback;
  final bool isSentimentAnalysisEnabled;

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
//  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();
  final FireBaseHelper _fireBaseHelper = FireBaseHelper();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTimeHelper _dateTimeHelper = new DateTimeHelper();
  SentimentAnalysisHelper _sentimentAnalysisHelper =
      SentimentAnalysisHelper(ApiBaseHelper(Client()));
  bool _isEnabled;
  String _journalEntry;

  @override
  void initState() {
    super.initState();
    initialiseJournalEntry();
    myController.addListener(_updateDoneIconEnabledState);
    _isEnabled = true;
  }

  void initialiseJournalEntry() {
    _fireBaseHelper
        .getJournalEntry(widget.userId, _dateTimeHelper.getCurrDateTime())
        .then(
      (journalEntry) {
        setState(
          () {
            _journalEntry = journalEntry;
            myController.text = _journalEntry;
          },
        );
      },
    );
  }

  _updateDoneIconEnabledState() {
    setState(
      () {
        _isEnabled = myController.text.isNotEmpty ? true : false;
      },
    );
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  updateJournalEntry(String journal) async {
    _fireBaseHelper.addJournalEntry(
        widget.userId, _dateTimeHelper.getCurrDateTime(), journal.toString());

    if (widget.isSentimentAnalysisEnabled) {
      await _sentimentAnalysisHelper
          .analyseTextSentiment(journal.toString())
          .then(
        (score) {
          _fireBaseHelper
              .addMood(widget.userId, _dateTimeHelper.getCurrDateTime(), score)
              .then(
            (x) {
              return;
            },
          );
        },
      );
    }
  }

  getIsEnabled() {
    return _isEnabled;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        gradient:
            LinearGradient(colors: [Color(0xffFF7E7E), Color(0xffFCE691)]),
        title: const Text("What's on your mind?"),
        actions: [
          new IconButton(
              icon: new Icon(Icons.done),
              onPressed: _isEnabled
                  ? () async {
                      var input = myController.text;
                      myController.clear();
                      await updateJournalEntry(input.toString());
                      Navigator.pop(context);
                    }
                  : null),
        ],
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
    );
  }
}
