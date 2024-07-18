import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:pogodabezradar/pages/HomePage.dart';
import 'package:pogodabezradar/pages/SearchPage.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await initializeDateFormatting('pl_PL', null);

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
            title: Container(
              alignment: AlignmentDirectional.center,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Pogoda",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      // margin: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100)),
                      child: Image.asset("assets/img/elderflower.png",
                          width: 70, colorBlendMode: BlendMode.multiply),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text("Radar",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          overflow: TextOverflow.visible,
                        )),
                  )
                ],
              ),
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
