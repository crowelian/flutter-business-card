import 'dart:async';
import 'config.dart';
import 'package:http/http.dart' as http;

class TokenProvider {
  Future<String> generateToken(String userId) async {
    final String uri = Config.generateTokenUrl + userId;
    final response = await http
        .get(
      Uri.parse(uri),
    )
        .timeout(Duration(seconds: Config.httpTimeout), onTimeout: () {
      throw TimeoutException("Request to generate token timed out!");
    });

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Could not generate token!");
    }
  }
}
