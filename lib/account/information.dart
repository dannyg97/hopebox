import 'package:flutter/material.dart';
import 'package:my_app/registration/authentication.dart';

class AccountPage extends StatelessWidget {

  AccountPage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  
  
  signOut() async {
    try {
      await this.auth.signOut();
      this.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Settings'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 30),
        RaisedButton(
          onPressed: () { 
              signOut();
          },
          child: const Text(
            'Logout',
            style: TextStyle(fontSize: 20)
          ),
        ),
          ],
        )
        
      )
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
