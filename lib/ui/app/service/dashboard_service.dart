import 'dart:convert';
import 'package:http/http.dart' as http;

class DashboardService {
  final String baseUrl;

  DashboardService({required this.baseUrl});

  Future<int> fetchCount(String endpoint) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/$endpoint"));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data["count"] ?? 0;
      } else {
        throw Exception("Erro ${response.statusCode} ao buscar $endpoint");
      }
    } catch (e) {
      throw Exception("Erro ao buscar $endpoint: $e");
    }
  }
}