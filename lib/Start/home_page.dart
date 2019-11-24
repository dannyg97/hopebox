import 'package:flutter/material.dart';
import '../registration/authentication.dart';
import 'package:firebase_database/firebase_database.dart';
import '../datasets/todo.dart';
import 'dart:async';
import '../account/information.dart';
import '../mood_entry.dart';
import '../history/history.dart';
import '../analysis/analysis.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import '../past_entries/past_entries.dart';
import '../fire_base_helper.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Todo> _todoList;

  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final _textEditingController = TextEditingController();
  StreamSubscription<Event> _onTodoAddedSubscription;
  StreamSubscription<Event> _onTodoChangedSubscription;
  FireBaseHelper fbh = new FireBaseHelper();

  Query _todoQuery;

  Widget getPastEntries() {
    return FutureBuilder(
      builder: (context, fireBaseSnap) {
        if (fireBaseSnap.connectionState == ConnectionState.done) {
          return PastEntries(
              auth: widget.auth,
              userId: widget.userId,
              logoutCallback: widget.logoutCallback,
              entryInstances: fireBaseSnap.data.reversed.toList());
        }
        return Container(width: 0.0, height: 0.0);
      },
      future: fbh.getAllUserEntryInstances(widget.userId),
    );
  }

  //bool _isEmailVerified = false;

  @override
  void initState() {
    super.initState();

    //_checkEmailVerification();

    _todoList = new List();
    _todoQuery = _database
        .reference()
        .child("todo")
        .orderByChild("userId")
        .equalTo(widget.userId);
    _onTodoAddedSubscription = _todoQuery.onChildAdded.listen(onEntryAdded);
    _onTodoChangedSubscription =
        _todoQuery.onChildChanged.listen(onEntryChanged);
  }

  @override
  void dispose() {
    _onTodoAddedSubscription.cancel();
    _onTodoChangedSubscription.cancel();
    super.dispose();
  }

  onEntryChanged(Event event) {
    var oldEntry = _todoList.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    setState(() {
      _todoList[_todoList.indexOf(oldEntry)] =
          Todo.fromSnapshot(event.snapshot);
    });
  }

  onEntryAdded(Event event) {
    setState(() {
      _todoList.add(Todo.fromSnapshot(event.snapshot));
    });
  }

  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  addNewTodo(String todoItem) {
    if (todoItem.length > 0) {
      Todo todo = new Todo(todoItem.toString(), widget.userId, false);
      _database.reference().child("todo").push().set(todo.toJson());
    }
  }

  updateTodo(Todo todo) {
    //Toggle completed
    todo.completed = !todo.completed;
    if (todo != null) {
      _database.reference().child("todo").child(todo.key).set(todo.toJson());
    }
  }

  deleteTodo(String todoId, int index) {
    _database.reference().child("todo").child(todoId).remove().then((_) {
      print("Delete $todoId successful");
      setState(() {
        _todoList.removeAt(index);
      });
    });
  }

  showAddTodoDialog(BuildContext context) async {
    _textEditingController.clear();
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: new Row(
              children: <Widget>[
                new Expanded(
                    child: new TextField(
                  controller: _textEditingController,
                  autofocus: true,
                  decoration: new InputDecoration(
                    labelText: 'Add new todo',
                  ),
                ))
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              new FlatButton(
                  child: const Text('Save'),
                  onPressed: () {
                    addNewTodo(_textEditingController.text.toString());
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black);

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text("Index 3:", style: optionStyle)
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _getPageWidget(int pos) {
    switch (pos) {
      case 0:
        return getPastEntries();
      case 1:
        return new HistoryPage(
            auth: widget.auth,
            userId: widget.userId,
            logoutCallback: widget.logoutCallback);
      case 2:
        return new AnalysisPage(
            auth: widget.auth,
            userId: widget.userId,
            logoutCallback: widget.logoutCallback);
      case 3:
        return new AccountPage(
              auth: widget.auth,
            userId: widget.userId,
            logoutCallback: widget.logoutCallback
        );
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Center(
            child:
                new Text("hopebox", style: TextStyle(fontFamily: 'Pacifico'))),
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffff2d55),
      ),
      body: _getPageWidget(_selectedIndex),
      bottomNavigationBar: FancyBottomNavigation(
        tabs: [
          TabData(iconData: Icons.home, title: "Home"),
          TabData(iconData: Icons.calendar_today, title: "Calendar"),
          TabData(iconData: Icons.equalizer, title: "Analysis"),
          TabData(iconData: Icons.settings, title: "Settings")
        ],
        onTabChangedListener: (position) {
          setState(() {
            _selectedIndex = position;
          });
        },
        barBackgroundColor: Color(0xffff2d55),
        circleColor: Colors.white,
        inactiveIconColor: Colors.white,
        activeIconColor: Color(0xffff2d55),
        textColor: Colors.white,
      ),
    );
  }
}
