import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_business_card/user.dart';
import 'package:http/http.dart' as http;

class JsonDataProvider {
  Future<User> fetchUserDataFromUrl(String uri) async {
    final response = await http.get(Uri.parse(uri));

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
