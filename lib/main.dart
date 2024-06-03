import 'package:flutter/material.dart';
import 'package:pogodabezradar/HomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
        title: const Text("Pogoda bez radar"),
        backgroundColor: Colors.blue[300],
      )),
    );
  }
}
