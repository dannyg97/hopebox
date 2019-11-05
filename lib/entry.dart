import 'package:firebase_database/firebase_database.dart';

class Entry {
  String key;
  String mood;
  String journal;
  bool completed;
  String userId;

  Entry(this.mood, this.journal, this.userId, this.completed);

  Entry.fromSnapshot(DataSnapshot snapshot) :
    key = snapshot.key,
    userId = snapshot.value["userId"],
    journal = snapshot.value["journal"],
    mood = snapshot.value['mood'],
    completed = snapshot.value["completed"];

  toJson() {
    return {
      "userId": userId,
      "journal": journal,
      "mood": mood, 
      "completed": completed,
    };
  }
}