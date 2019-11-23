<<<<<<< HEAD
import 'dart:math';

import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/material.dart';
import 'package:my_app/registration/authentication.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:my_app/fire_base_helper.dart';
import 'package:my_app/sentiment_analysis_helper.dart';
import 'package:my_app/api_base_helper.dart';
import 'package:http/http.dart';
import 'package:my_app/entry_instance.dart';
import 'package:my_app/date_time_helper.dart';
import 'dart:io';



=======
import 'package:flutter/material.dart';
>>>>>>> parent of caadb69... Merge branch 'master' of github.com:dannyg97/hopebox

class HistoryPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return MaterialApp(
      title: 'Your History',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
          auth: this.auth,
          userId: this.userId,
          logoutCallback: this.logoutCallback,
          title: 'Your History'
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.auth, this.userId, this.logoutCallback, this.title}) : super(key: key);
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  final String title;

  String get user_ID {
    return userId;
  }


  @override
  _MyHomePageState createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  // a mapping of certain arbitrary events to a name
  Map<DateTime, List> _events = Map();
  List _selectedEvents;

  // begin to call the calendar
  AnimationController _animationController;
  CalendarController _calendarController;
  final _formKey = GlobalKey<FormState>();

  // our helper function to control firebase
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final FireBaseHelper _fireBaseHelper = FireBaseHelper();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  DateTimeHelper _dateTimeHelper = new DateTimeHelper();



  int emoji;


  String getMood(int mood) {
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
      returnS = 'You were feeling happy!';
      return returnS;
      case 4:
        returnS = 'You were feeling ecstatic!';
        return returnS;
    }
  }

  List<String> _entryDates;
  List<int> entryYear = [];
  List<int> entryMonth = [];
  List<int> entryDay = [];
  List<int> moodRating = [];
  var entries = new List<String>();
  var combinedEntry = new List<String>();


  Future <void> getEntries(String userId)  {

    _fireBaseHelper.getAllDatesWithMoodOrJournalEntries(userId).then((dates){
      setState(() {
        _entryDates = dates;
        print(_entryDates.length);
        for(var i = 0; i < _entryDates.length; i++) {
          List temp = [];
          temp = _entryDates[i].split("-");
          entryYear.add(int.parse(temp[0]));
          entryMonth.add(int.parse(temp[1]));
          entryDay.add(int.parse(temp[2]));
        }
      });
    });
  }






  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();

    _fireBaseHelper.getAllDatesWithMoodOrJournalEntries(widget.userId).then((dates){
      setState(() {
        _entryDates = dates;
        print(_entryDates.length);
        for(var i = 0; i < _entryDates.length; i++) {

          _fireBaseHelper.getMood(widget.userId, _entryDates[i]).then((mood){
            setState(() {

              moodRating.add(mood);

              _fireBaseHelper.getJournalEntry(widget.userId, _entryDates[i]).then((journalEntry){
                setState(() {
                  entries.add(journalEntry);

                });
              });

            });
          });



          List temp = [];
          temp = _entryDates[i].split("-");
          entryYear.add(int.parse(temp[0]));
          entryMonth.add(int.parse(temp[1]));
          entryDay.add(int.parse(temp[2]));

        }
        _events = {
         // DateTime(entryYear[0], entryMonth[0], entryDay[0]):['slidjfskdjfsd'],
          _selectedDay.subtract(Duration(days: 1000)): ['Event A2', 'Event B2', 'Event C2', 'Event D2'],
          _selectedDay.subtract(Duration(days: 900)): ['Event A2', 'Event B2', 'Event C2', 'Event D2'],


        };

        _selectedEvents = _events[_selectedDay] ?? [];

      });
    });

    _calendarController = CalendarController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  // what happens on the day you have clicked
  void _onDaySelected(DateTime day, List events) {
    final _selectedDay = DateTime.now();

    for(var i = 0; i < entryYear.length; i++) {
     // _events[DateTime(entryYear[i], entryMonth[i], entryDay[i])] = [entries[i]];
      String returnS = getMood(moodRating[i]);
      var time = new DateTime(entryYear[i], entryMonth[i], entryDay[i]);
      String addEntry = '';
      addEntry = entries[i];
      /*if(entries[i]!= null) {
        addEntry = entries[i];
      }*/
      String combinedMessage = returnS + ' and you wrote: \n' + addEntry;
      _events[time] = [combinedMessage];
      };


    _selectedEvents = _events[_selectedDay] ?? [];

    setState(() {
      _selectedEvents = events;
    });
  }

  // WE'LL COME BACK TO THIS
  void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
  }

  // OVERRIDE SOMETHING
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _buildTableCalendar(),
          const SizedBox(height: 8.0),
          _buildButtons(),
          const SizedBox(height: 8.0),
          Expanded(child: _buildEventList()),
        ],
      ),
    );
  }

  // Simple TableCalendar configuration (using Styles)
  Widget _buildTableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      events: _events,
      //holidays: _holidays,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        selectedColor: Colors.blueAccent[400],        // this is the date selected
        todayColor: Colors.tealAccent[200], // today's date
        markersColor: Colors.red[700], // this is the marker colour
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        // this is the colour of the month/week/fortnight toggle
        formatButtonTextStyle: TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.deepOrange[400],
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
    );
  }

  // More advanced TableCalendar configuration (using Builders & Styles)
  Widget _buildTableCalendarWithBuilders() {
    return TableCalendar(
      locale: 'pl_PL',
      calendarController: _calendarController,
      events: _events,
      //holidays: _holidays,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: '',
        CalendarFormat.week: '',
      },
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
        holidayStyle: TextStyle().copyWith(color: Colors.blue[800]),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle().copyWith(color: Colors.blue[600]),
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
      ),
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.only(top: 5.0, left: 6.0),
              color: Colors.deepOrange[300],
              width: 100,
              height: 100,
              child: Text(
                '${date.day}',
                style: TextStyle().copyWith(fontSize: 16.0),
              ),
            ),
          );
        },
        todayDayBuilder: (context, date, _) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.only(top: 5.0, left: 6.0),
            color: Colors.amber[400],
            width: 100,
            height: 100,
            child: Text(
              '${date.day}',
              style: TextStyle().copyWith(fontSize: 16.0),
            ),
          );
        },
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];
          // this is where we can add events
          if (events.isNotEmpty) {
            children.add(
              Positioned(
                right: 1,
                bottom: 1,
                child: _buildEventsMarker(date, events),
              ),
            );
          }
          // add holiday's into the calendar (if wanted)
          if (holidays.isNotEmpty) {
            children.add(
              Positioned(
                right: -2,
                top: -2,
                child: _buildHolidaysMarker(),
              ),
            );
          }

          return children;
        },
      ),
      onDaySelected: (date, events) {
        _onDaySelected(date, events);
        _animationController.forward(from: 0.0);
      },
      onVisibleDaysChanged: _onVisibleDaysChanged,
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: _calendarController.isSelected(date)
            ? Colors.brown[500]
            : _calendarController.isToday(date) ? Colors.brown[300] : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
=======
    return Container(
      decoration: BoxDecoration(color: Colors.white),
>>>>>>> parent of caadb69... Merge branch 'master' of github.com:dannyg97/hopebox
      child: Center(
        child: Text(
          'History',
          textDirection: TextDirection.ltr,
          style: TextStyle(
            fontSize: 32,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
<<<<<<< HEAD

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }

  Widget _buildButtons() {
    final dateTime = _events.keys.elementAt(_events.length - 2);

    return Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              child: Text('Month'),
              onPressed: () {
                setState(() {
                  _calendarController.setCalendarFormat(CalendarFormat.month);
                });
              },
            ),
            RaisedButton(
              child: Text('Fortnight'),
              onPressed: () {
                setState(() {
                  _calendarController.setCalendarFormat(CalendarFormat.twoWeeks);
                });
              },
            ),
            RaisedButton(
              child: Text('Week'),
              onPressed: () {
                setState(() {
                  _calendarController.setCalendarFormat(CalendarFormat.week);
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        RaisedButton(
          child: Text('Select Todays Date'),
          onPressed: () {
            _calendarController.setSelectedDay(
              DateTime.now(),
              runCallback: true,
            );
          },
          color: Colors.greenAccent
        ),
      ],
    );
  }

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents
          .map((event) => Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.8),
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: ListTile(
          title: Text(event.toString()),
          //onTap: () => print('$event tapped!'),
        ),
      ))
          .toList(),
    );
  }
=======
>>>>>>> parent of caadb69... Merge branch 'master' of github.com:dannyg97/hopebox
}

