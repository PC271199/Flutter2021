
import 'package:flutter/material.dart';
import 'package:blog/screens/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
   Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog app',
      theme: ThemeData.dark(
      ),
      home: Home(),
    );
  }
}
