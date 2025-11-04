import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/psychologist_model.dart';

class PsychologistService {
  final String baseUrl = "https://api.nextmind.sbs";

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  /// Busca psicólogos pendentes
  Future<List<PsychologistModel>> getPendingPsychologists({int page = 1}) async {
    final token = await _getToken();
    if (token == null || token.isEmpty) throw Exception("Token não encontrado.");

    final url = Uri.parse('$baseUrl/admin/psychologists?status=pending&page=$page');
    final response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final List data = jsonResponse['data'] ?? [];
      return data.map((e) => PsychologistModel.fromJson(e)).toList();
    } else if (response.statusCode == 401) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove("token");
      throw Exception("Token expirado. Faça login novamente.");
    } else {
      throw Exception("Erro ${response.statusCode}: ${response.body}");
    }
  }

  /// Aprova um documento específico
  Future<void> approveDocument(String documentId) async {
    final token = await _getToken();
    if (token == null || token.isEmpty) throw Exception("Token não encontrado.");

    final url = Uri.parse('$baseUrl/admin/psychologists/documents/$documentId/approve');
    final response = await http.patch(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final status = jsonResponse["data"]["status"];
      if (status != "approved") throw Exception("Erro ao aprovar documento.");
    } else {
      throw Exception("Erro ao aprovar documento: ${response.statusCode}");
    }
  }

  /// Reprova um documento específico
  Future<void> rejectDocument(String documentId) async {
    final token = await _getToken();
    if (token == null || token.isEmpty) throw Exception("Token não encontrado.");

    final url = Uri.parse('$baseUrl/admin/psychologists/documents/$documentId/repprove');
    final response = await http.patch(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final status = jsonResponse["data"]["status"];
      if (status != "repproved" && status != "rejected") {
        throw Exception("Erro ao reprovar documento.");
      }
    } else {
      throw Exception("Erro ao reprovar documento: ${response.statusCode}");
    }
  }
}
