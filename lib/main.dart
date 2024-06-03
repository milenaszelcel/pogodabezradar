import 'package:flutter/material.dart';
import 'package:pogodabezradar/ApiConnect.dart';
import 'package:pogodabezradar/HomePage.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pogoda bez radar",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[300],
      ),
      body: const Homepage(),
    ));
  }
}
