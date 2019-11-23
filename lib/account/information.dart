import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {

  // AccountPage({Key key, this.auth, this.userId, this.logoutCallback})
  //     : super(key: key);
  // final BaseAuth auth;
  // final VoidCallback logoutCallback;
  // final String userId;
  
  
  // signOut() async {
  //   try {
  //     await widget.auth.signOut();
  //     widget.logoutCallback();
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal info'),
      ),
      body: Container(
        child: Text("hello")   
      ),
    );
  }
}


Widget Avator()=>Stack (
      alignment: const Alignment(0.6, 0.6),
      children: <Widget>[
        CircleAvatar(
          backgroundImage: AssetImage(''),
          radius: 80,
        ),

      ],
);