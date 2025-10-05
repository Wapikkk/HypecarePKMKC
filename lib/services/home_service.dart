import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/home_data.dart';

class HomeService {
  static const String _baseUrl = 'http://72.60.76.92:3000/api/home'; // Endpoint baru
  final _storage = const FlutterSecureStorage();

  Future<HomeData> fetchHomeData() async {
    try {
      final token = await _storage.read(key: 'jwt_token');
      if (token == null) throw Exception('Token tidak ditemukan.');

      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        return HomeData.fromJson(responseBody['data']);
      } else {
        throw Exception('Gagal memuat data beranda');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }
}