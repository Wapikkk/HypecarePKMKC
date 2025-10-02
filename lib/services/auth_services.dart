import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class AuthService {
  static const String _baseUrl = 'http://72.60.76.92:3000/api/auth';

 Future<Map<String, dynamic>> register ({
  required String email, 
  required String password, 
  required String confirmPassword, 
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String> {
          'email': email,
          'password': password,
          'confirmPassword': confirmPassword,
        }),
      ).timeout(const Duration(seconds: 2));

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return {'success': true, 'message': responseBody['message']};
      } else {
        return {'success': false, 'message': responseBody['message']};
      }
    } catch (e) {
      print ('Registraion error: $e');
      return {'success': false, 'message': 'Registrasi gagal.'};
    }
  }

  Future<Map<String, dynamic>> login ({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: <String, String> {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String> {
          'email': email,
          'password': password,
        }),
      ).timeout(const Duration(seconds: 3));

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {'success': true, 'token': responseBody['token']};
      } else {
        return {'success': false, 'message': responseBody['message']};
      }
    } catch (e) {
      print('Loggin Error: $e');
      return {'success': false, 'message': 'Login gagal.'};
    }
  }
}