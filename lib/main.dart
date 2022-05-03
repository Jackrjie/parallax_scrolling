import 'package:flutter/material.dart';
import 'package:parallax_scrolling/parallex_scrolling_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parallax Scrolling',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ParallaxScrollingScreen()
    );
  }
}