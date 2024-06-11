import 'package:flutter/material.dart';
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Pogoda",
              style: TextStyle(color: Colors.white, fontSize: 32),
            ),
            Container(
              margin: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100)),
              child: Image.asset("assets/img/elderflower.png",
                  width: 70, colorBlendMode: BlendMode.multiply),
            ),
            const Text("Radar",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                ))
          ],
        ),
        backgroundColor: Colors.blue[300],
        toolbarHeight: 80,
      ),
      body: const Homepage(),
    ));
  }
}
