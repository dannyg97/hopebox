import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class Journal {
  String key;
  String journal;
  bool completed;
  String userId;
  String formatted = DateFormat('yyyyMMdd').format(DateTime.now());
  Journal(this.journal, this.userId, this.completed);

  Journal.fromSnapshot(DataSnapshot snapshot) :
    key = snapshot.key,
    userId = snapshot.value["userId"],
    journal = snapshot.value["journal"],
    completed = snapshot.value["completed"];

  toJson() {
    return {
      "userId": userId,
      "journal": journal,
      "completed": completed,
       "createDate": formatted,
    };
  }
}