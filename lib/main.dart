import 'package:flutter/material.dart';
import 'package:todopal/views/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TodoPal App',
      home: HomePage(),
    );
  }
}
