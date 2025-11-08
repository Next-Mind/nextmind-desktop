import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/audit_model.dart';

class AuditService {
  final String baseUrl = "https://api.nextmind.sbs";

  Future<List<Audit>> fetchAudits() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    if (token == null) throw Exception("Token não encontrado");

    final url = Uri.parse("$baseUrl/audits");

    final response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List list = data['data'];
      return list.map((e) => Audit.fromJson(e)).toList();
    } else {
      print("Erro ao carregar auditorias: ${response.statusCode} - ${response.body}");
      throw Exception("Erro ao carregar auditorias: ${response.statusCode} - ${response.body}");
    }
  }
}
