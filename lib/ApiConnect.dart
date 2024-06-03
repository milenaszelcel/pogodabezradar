import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:pogodabezradar/env/env.dart';

Future<http.Response> fetchAlbum() async {
  return await http.get(Uri.parse(Env.url));
}
