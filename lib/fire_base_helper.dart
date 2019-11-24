import 'package:my_app/datasets/entry.dart';

import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:my_app/entry_instance.dart';

class FireBaseHelper {
    final fs.Firestore _firestore = fs.Firestore.instance;

    Future<List<EntryInstance>> getAllUserEntryInstances(String userId) async {
        List<String> dates = await getAllDatesWithMoodOrJournalEntries(userId);
        List<EntryInstance> entryInstances = await addEntryInstances(userId, dates);
        return entryInstances;
    }
 
    Future<List<EntryInstance>> addEntryInstances(String userId, List<String> dates) async {
        List<EntryInstance> entryInstances = new List();
        for (String date in dates) {
            String journalEntry = await getJournalEntry(userId, date);
            int mood = await getMood(userId, date);
            EntryInstance entryInstance = new EntryInstance(date, journalEntry, mood);
            entryInstances.add(entryInstance);
        }
        return entryInstances;
    }

    Future<List<String>> getAllDatesWithMoodOrJournalEntries(String userId) async {
        List<String> dates = new List();
        await _firestore.collection("users")
            .document(userId)
            .collection("dates")
            .getDocuments().then((documentList){
                for (var value in documentList.documents) {
                    dates.add(value.documentID);
                }
            });
        return dates;
    }

    // Returns the journal entry for a user on a particular date, if it doesn't exist it will return null.
    Future<String> getJournalEntry(String userId, String dateTime) async {
        String journalEntry;
        await _firestore.collection("users")
            .document(userId)
            .collection("dates")
            .document(dateTime)
            .collection("user_entries")
            .document("journal").get().then((snapshot){
                journalEntry = snapshot.data["journal_entry"];
            });
        return journalEntry;
    }

    // Returns the mood for a specific user on a particular date
    // If the returned value is -1 it means there's no recorded mood.
    Future<int> getMood(String userId, String dateTime) async {
        int mood = -1;
        await _firestore.collection("users")
            .document(userId)
            .collection("dates")
            .document(dateTime)
            .collection("user_entries")
            .document("mood").get().then((snapshot){
            mood = snapshot.data["mood"];
        });
        return mood;
    }

    void addJournalEntry(String userId, String dateTime, String journalEntry) {
        Map<String, dynamic> data = {'journal_entry':journalEntry};
        _firestore.collection("users")
            .document(userId)
            .collection("dates")
            .document(dateTime)
            .collection("user_entries")
            .document("journal")
            .setData(data);
    }

    void addMood(String userId, String dateTime, int mood) {
        Map<String, dynamic> data = {'mood': mood};
        _firestore.collection("users")
            .document(userId)
            .collection("dates")
            .document(dateTime)
            .collection("user_entries")
            .document("mood")
            .setData(data);
    }
}