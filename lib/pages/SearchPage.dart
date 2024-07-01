import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pogodabezradar/location/LocationService.dart';

class SearchPage extends StatefulWidget {
  final VoidCallback navigateToHomePage;

  const SearchPage({super.key, required this.navigateToHomePage});

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
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text("Lokalizacja zapisana pomyślnie"),
          onVisible: () {
            widget.navigateToHomePage();
          },
        ));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Nie znaleziono lokalizacji.")),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                margin: const EdgeInsets.all(15.0),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  controller: locationController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2.0)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 1.0)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 1.0)),
                    contentPadding: const EdgeInsets.all(15.0),
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
                )),
            ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(300, 15),
                  foregroundColor: Colors.blue,
                  padding: const EdgeInsets.all(15.0),
                  backgroundColor: Colors.white,
                  textStyle: const TextStyle(
                    fontSize: 20,
                  )),
              child: const Text("Szukaj"),
            ),
          ],
        ),
      ),
    );
  }
}
