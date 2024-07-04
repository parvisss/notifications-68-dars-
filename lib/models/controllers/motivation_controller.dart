import 'dart:math';
import 'package:frp/services/http_motivation.dart';

class MotivationController {
  final HttpMotivation httpMotivation = HttpMotivation();

  Future<List> fetchMotivation() async {
    final List<dynamic> motivations = await httpMotivation.getMotivasions();

    if (motivations.isNotEmpty) {
      int randomIndex = Random().nextInt(motivations.length);
      List author = motivations[randomIndex]['author'].toString().split(",");
      return [
        motivations[randomIndex]['text'],
        author[0],
      ];
    } else {
      throw Exception('No motivations available');
    }
  }
}
