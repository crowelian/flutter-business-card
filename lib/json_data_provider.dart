import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_business_card/config.dart';
import 'package:flutter_business_card/token_provider.dart';

import 'package:flutter_business_card/user.dart';
import 'package:http/http.dart' as http;

class JsonDataProvider {
  Future<User> fetchUserDataWithJwt(String userId) async {
    String token = await TokenProvider().generateToken(userId);

    final response = await http.get(
      Uri.parse(Config.userDataApiUrl),
      headers: {
        "Authorization": "Bearer $token",
      },
    ).timeout(Duration(seconds: Config.httpTimeout), onTimeout: () {
      throw TimeoutException("Request to fetch user data with Jwt timed out!");
    });
    ;

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception("Could not fetch user data with JWT");
    }
  }

  Future<User> fetchUserDataFromUrl() async {
    final response = await http
        .get(Uri.parse(Config.userDataApiUrl))
        .timeout(Duration(seconds: Config.httpTimeout), onTimeout: () {
      throw TimeoutException("Request to fetch user data from url timed out!");
    });
    ;

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception("Could not fetch user data");
    }
  }

  Future<User> fetchUserDataFromAssets() async {
    String jsonString =
        await rootBundle.loadString("assets/json/user_data.json");

    Map<String, dynamic> jsonData = jsonDecode(jsonString);
    return User.fromJson(jsonData);
  }
}
