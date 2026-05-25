import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthServices {
  static const String baseUrl = 'http://192.168.1.122:5000';

  static Future<bool> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String passwordConfirm,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-type': 'application/json'},
        body: jsonEncode({
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'password': password,
          'passwordConfirm': passwordConfirm,
        }),
      );
      if (response.statusCode == 200) {
        print('Success: ${response.body}');
        return true;
      } else {
        print('Failed: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
