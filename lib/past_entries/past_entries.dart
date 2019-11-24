import 'package:flutter/material.dart';
import '../registration/authentication.dart';
import '../entry_instance.dart';
import '../mood_entry.dart';

class PastEntries extends StatefulWidget{
  PastEntries({Key key,this.auth, this.userId, this.logoutCallback, this.entryInstances})
      : super(key: key);
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  final List<EntryInstance> entryInstances;
  
  @override
  State<StatefulWidget> createState() => _PastEntries(); 
}

class _PastEntries extends State<PastEntries>{  
  @override 
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Map<int, IconData> moodToIcon = {
        0: Icons.sentiment_very_dissatisfied, 
        1: Icons.sentiment_dissatisfied,
        2: Icons.sentiment_neutral,
        3: Icons.sentiment_satisfied,
        4: Icons.sentiment_very_satisfied,
      };
    return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MoodEnter(
                      userId: widget.userId,
                      auth: this.widget.auth,
                      logoutCallback: widget.logoutCallback,
                    ),
                  ),
                );
              },
              child: Text(
                'ADD A NEW ENTRY',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.bold,
                ),
              ),
              color: Color(0xffff2d55),
              elevation: 0,
              minWidth: 400,
              height: 50,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.entryInstances.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Container(
                    decoration: new BoxDecoration(
                      color: Color(0xffffffff),
                      border: Border.all(color: Color(0xffff2d55)),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ListTile(
                      leading:
                          Icon(moodToIcon[widget.entryInstances[index].toJson()["mood"]] , size: 40, color: Colors.black87),
                      title: Text(
                        widget.entryInstances[index].toJson()["date_time"],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        widget.entryInstances[index].toJson()["journal_entry"],
                        style: TextStyle(color: Colors.black87),
                      ),
                      contentPadding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      );
  }
}
