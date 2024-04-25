import 'dart:convert';
import 'package:loggy/loggy.dart';
import 'package:http/http.dart' as http;

class AuthenticationDatatasource {
  Future<bool> login(String baseUrl, String email, String password) async {
    final response = await http.get(
      Uri.parse('$baseUrl?Email=$email&Password=$password'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }
    );

    logInfo(response.statusCode);
    logInfo(response.body);
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData is List && responseData.length == 1) {
        logInfo("solo 1");
        return true;
      } else {
        logInfo("mas de 1");
        return false;
      }
    } else {
      logError("Got error code ${response.statusCode}");
      return false;
    }
  }

  Future<bool> logOut() async {
    return Future.value(true);
  }
}
