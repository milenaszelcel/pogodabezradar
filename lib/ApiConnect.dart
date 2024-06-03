import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:pogodabezradar/env/env.dart';

class ApiService {
  Future getWeather() async {
    final response = await http.get(Uri.parse(Env.url));
    if (response.statusCode == 200) {
      var body = response.body;
      return jsonDecode(body);
    } else {
      throw Exception("Nie dziala");
    }
  }
}
