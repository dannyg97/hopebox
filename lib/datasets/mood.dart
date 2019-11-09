import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class Mood {
  String key;
  String mood;
  bool completed;
  String userId;
  String formatted = DateFormat('yyyyMMdd').format(DateTime.now());
  Mood(this.mood, this.userId, this.completed);

  Mood.fromSnapshot(DataSnapshot snapshot) :
    key = snapshot.key,
    userId = snapshot.value["userId"],
    mood = snapshot.value["mood"],
    completed = snapshot.value["completed"];

  toJson() {
    return {
      "userId": userId,
      "mood": mood,
      "completed": completed,
      "createDate": formatted,
    };
  }
}