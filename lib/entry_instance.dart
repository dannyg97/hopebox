class EntryInstance {
    String dateTime;
    String journalEntry;
    int mood;

    EntryInstance(this.dateTime, this.journalEntry, this.mood);

    toJson() {
        return {
            "date_time": dateTime,
            "journal_entry": journalEntry,
            "mood": mood,
        };
    }
}