import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pogodabezradar/location/LocationService.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final locationController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late Future<LocationService> _locationServiceFuture;

  @override
  void initState() {
    super.initState();
    _locationServiceFuture = LocationService.create();
  }

  onPressed() async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Szukanie. Proszę czekać")),
      );

      try {
        final locationService = await _locationServiceFuture;
        await locationService.getLocationAndSave(locationController.text);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Lokalizacja zapisana pomyślnie")),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Błąd: ${e.toString()}")),
        );
      }
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: locationController,
              decoration: const InputDecoration(
                hintText: 'Wpisz lokalizacje',
                filled: true,
                fillColor: Colors.white,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Proszę wpisać lokalizację';
                }
                return null;
              },
            ),
            ElevatedButton(onPressed: onPressed, child: const Text("Szukaj")),
          ],
        ),
      ),
    );
  }
}
