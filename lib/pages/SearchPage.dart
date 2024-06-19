import 'package:flutter/material.dart';
import 'package:pogodabezradar/location/LocationService.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  onPressed() {
    if (searchKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Szukanie. Proszę czekać")));
    }
  }

  final searchKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[200],
        body: Form(
            key: searchKey,
            child: Column(children: [
              TextFormField(
                decoration: const InputDecoration(
                    hintText: 'Wpisz lokalizacje',
                    filled: true,
                    fillColor: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Proszę wpisać lokalizację';
                  }
                  return null;
                },
              ),
              ElevatedButton(onPressed: onPressed, child: Text("Szukaj"))
            ])));
  }
}
