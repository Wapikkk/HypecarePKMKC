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
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        Map<String, dynamic>? data = responseBody['data'];
        
        if (data == null) {
          return [];
        }

        List<dynamic> estimationList = data['estimationData'] ?? [];
        List<dynamic> predictionList = data['predictionData'] ?? [];

        final List<dynamic> allHistoryItems = [...estimationList, ...predictionList];

        if (allHistoryItems.isEmpty) {
          return [];
        }

        final List<DailyHistory> historyList = allHistoryItems.map((jsonItem) {
          return DailyHistory.fromJson(jsonItem as Map<String, dynamic>);
        }).toList();

        return historyList;
      } else {
        final errorBody = jsonDecode(response.body);
        throw Exception('Gagal mengambil data riwayat: ${errorBody['message']}');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }
}