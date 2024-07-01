import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:pogodabezradar/pages/HomePage.dart';
import 'package:pogodabezradar/pages/SearchPage.dart';

Future<void> main() async {
  await Hive.initFlutter();

  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentPageIndex = 0;

  void _updatePageIndex(int newIndex) {
    setState(() {
      _currentPageIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: MaterialApp(
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
                _currentPageIndex = index;
              });
            },
            backgroundColor: Colors.blue[300],
            selectedIndex: _currentPageIndex,
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
          body: _currentPageIndex == 0
              ? const Homepage()
              : SearchPage(navigateToHomePage: () => _updatePageIndex(0)),
        )));
  }
}
