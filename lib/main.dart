import 'package:flutter/material.dart';
import 'package:pogodabezradar/pages/HomePage.dart';
import 'package:pogodabezradar/pages/SearchPage.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentPageIndex = 0;

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
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        backgroundColor: Colors.blue[300],
        selectedIndex: currentPageIndex,
        indicatorColor: Colors.white,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Strona Główna',
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            label: 'Szukaj',
          ),
        ],
      ),
      body: currentPageIndex == 0 ? const Homepage() : const SearchPage(),
    ));
  }
}
