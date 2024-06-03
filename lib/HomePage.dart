import 'package:flutter/material.dart';
import 'package:pogodabezradar/env/env.dart';

import 'package:http/http.dart' as http;

Future<http.Response> fetchAlbum() async {
  return await http.get(Uri.parse(Env.url));
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
