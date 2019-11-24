import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:my_app/entry_instance.dart';

class FireBaseHelper {
    final fs.Firestore _firestore = fs.Firestore.instance;
    String transformMood(int mood) {
        String returnS = '';
        switch (mood) {
        case 0:
            returnS = 'You were feeling awful';
            return returnS;
        case 1:
            returnS = 'You were feeling a bit on the bad side';
            return returnS;
        case 2:
            returnS = 'You were feeling neutral';
            return returnS;
        case 3:
            returnS = 'You were feeling happy';
            return returnS;
        case 4:
            returnS = 'You were feeling ecstatic';
            return returnS;
        }
    }

    Future<Map<DateTime, List>> getCalendarObjects(String userId) async {

        List<String> dates = await getAllDatesWithMoodOrJournalEntries(userId);
        Map<DateTime, List> _events = await addCalendarObjects(userId, dates);
        return _events;
    }

    Future<Map<DateTime, List>> addCalendarObjects(String userId, List<String> dates) async {
        Map<DateTime, List> events = Map();

        for (String date in dates) {
            String journalEntry = await getJournalEntry(userId, date);
            int mood = await getMood(userId, date);
            String transformedMood = transformMood(mood);
            String combinedMessage = transformedMood + ' and you wrote: \n' + journalEntry;
            List temp = [];
            temp = date.split("-");
            var time = DateTime(int.parse(temp[0]), int.parse(temp[1]), int.parse(temp[2]));
            events[time] = [combinedMessage];
        }
        return events;
    }

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

    Future<bool> getIsSentimentAnalysisEnabled(String userId) async {
        bool isSentimentAnalysisEnabled = false;
        await _firestore.collection("users")
            .document(userId)
            .collection("userOptIns")
            .document("isSentimentAnalysisEnabled").get().then((snapshot){
            isSentimentAnalysisEnabled = snapshot.data["isSentimentAnalysisEnabled"];
        });
        return isSentimentAnalysisEnabled;
    }

    void addJournalEntry(String userId, String dateTime, String journalEntry) {
        Map<String, dynamic> data = {'journal_entry':journalEntry};
        Map<String, dynamic> date = {'date': dateTime};
        
        _firestore.collection("users")
            .document(userId)
            .collection("dates")
            .document(dateTime)
            .setData(date);
            
        _firestore.collection("users")
            .document(userId)
            .collection("dates")
            .document(dateTime)
            .collection("user_entries")
            .document("journal")
            .setData(data);
    }

    Future<void> addMood(String userId, String dateTime, int mood) {
        Map<String, dynamic> data = {'mood': mood};
        Map<String, dynamic> date = {'date': dateTime};
        
        _firestore.collection("users")
            .document(userId)
            .collection("dates")
            .document(dateTime)
            .setData(date);

        return _firestore.collection("users")
            .document(userId)
            .collection("dates")
            .document(dateTime)
            .collection("user_entries")
            .document("mood")
            .setData(data);
    }

    void addSentimentAnalysisOptInStatus(String userId, bool isSentimentAnalysisEnabled) {
        Map<String, dynamic> data = {'isSentimentAnalysisEnabled': isSentimentAnalysisEnabled};
        _firestore.collection("users")
            .document(userId)
            .collection("userOptIns")
            .document("isSentimentAnalysisEnabled")
            .setData(data);
    }
}
