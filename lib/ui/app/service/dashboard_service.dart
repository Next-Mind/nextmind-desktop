import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DashboardService {
  final String baseUrl;

  DashboardService({required this.baseUrl});

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  Future<Map<String, String>> _getHeaders() async {
    final token = await _getToken();
    if (token == null) throw Exception("Token não encontrado");

    return {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };
  }

  Future<int> fetchCount(String endpoint) async {
  try {
    final headers = await _getHeaders();
    final url = Uri.parse("$baseUrl/$endpoint");

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData["data"]["count"] ?? 0;
    } else {
      throw Exception("Erro ${response.statusCode} ao buscar $endpoint");
    }
  } catch (e) {
    debugPrint("Erro ao buscar $endpoint: $e");
    return 0;
  }
}


  /// Busca uma lista de objetos
  Future<List<dynamic>> fecthList(String endpoint) async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(Uri.parse("$baseUrl/$endpoint"), headers: headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data is List ? data : [];
      } else {
        throw Exception("Erro ${response.statusCode} ao buscar $endpoint");
      }
    } catch (e) {
      throw Exception("Erro ao buscar $endpoint: $e");
    }
  }

  /// Busca estatísticas (retorna um Map)
  Future<Map<String, dynamic>> fecthStats(String endpoint) async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(Uri.parse("$baseUrl/$endpoint"), headers: headers);

      if (response.statusCode == 200) {
        return Map<String, dynamic>.from(json.decode(response.body));
      } else {
        throw Exception("Erro ${response.statusCode} ao buscar $endpoint");
      }
    } catch (e) {
      throw Exception("Erro ao buscar $endpoint: $e");
    }
  }
}
