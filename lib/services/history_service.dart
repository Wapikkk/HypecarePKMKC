import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hypecare_pkmkc/models/daily_history.dart';

class HistoryService {
  static const String _baseUrl = 'http://72.60.76.92:3000/api/history';
  final _storage = const FlutterSecureStorage();

  Future<List<DailyHistory>> fetchHistory() async {
    try {
      final token = await _storage.read(key: 'jwt_token');

      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        List<dynamic>? dataFromServer = responseBody['data'] as List<dynamic>?;
        List<DailyHistory> historyList = [];

        return historyList;
      } else {
        throw Exception('Gagal mengambil data riwayat');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }
}