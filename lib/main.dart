import 'package:flutter/material.dart';

import 'Start.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Start(),
      debugShowCheckedModeBanner: false,
    );
  }
}
