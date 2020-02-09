import 'package:flutter/material.dart';
import 'screens/home.dart';

class App extends StatelessWidget {
  Widget build(context) {
    return new MaterialApp(
      title: 'Animation',
      home: Home(),
      theme: ThemeData(
        primarySwatch: Colors.blue
      )
    );
  }

}