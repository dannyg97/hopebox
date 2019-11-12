class DateTimeHelper {
    String getCurrDateTime() {
        DateTime now = new DateTime.now();
        int year = now.year;
        int month = now.month;
        int day = now.day;

        return '$year-$month-$day';
    }
}