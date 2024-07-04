import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpMotivation {
  final url = "https://type.fit/api/quotes";
  Future<List> getMotivasions() async {
    final connect = Uri.parse(url);
    final data = await http.get(connect);

    if (data.statusCode == 200) {
      List motivations = jsonDecode(data.body);
      return motivations;
    }
    return ["error"];
  }
}
