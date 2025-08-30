import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String _baseUrl = 'https://103.157.97.91:3000/api/auth';

 Future<Map<String, dynamic>> register ({
  required String email, 
  required String password, 
  required String confirmPassword, 
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/register'),
        headers: <String, String>{
          'Conten-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String> {
          'email': email,
          'password': password,
          'confirmPassword': confirmPassword,
        }),
      );

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return {'succes': true, 'message': responseBody['message']};
      } else {
        return {'succes': false, 'message': responseBody['message']};
      }
    } catch (e) {
      return {'succes': false, 'message': 'Terjadi kesalahan. silakan coba lagi.'};
    }
  }

  
}