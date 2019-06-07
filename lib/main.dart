import 'package:flutter/material.dart';

import 'homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Animated charts app',
      theme: ThemeData(
        primaryColor: Color(0xffff6101)
      ),
      home: HomePage(),
    );
  }
}