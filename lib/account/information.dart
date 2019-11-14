import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
       children: <Widget>[
         Padding(
           padding: EdgeInsets.all(20.0),
         ),
         Align(
          alignment: Alignment(0.0, -0.8),
          child: Avator(),
        ),
        Padding(
           padding: EdgeInsets.only(top: 30.0),
           child: Text(
             'FirstName LastName',
             style: TextStyle(
               fontSize: 20,
               fontWeight: FontWeight.bold,
               color: Colors.blue,
             ),
           ),
         ),

       ],

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