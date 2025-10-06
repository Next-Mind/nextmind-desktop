import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AdminService {
  static const String _baseUrl = "https://api-staging.nextmind.tech";

  Future<Map<String, dynamic>> inviteAdmin(String email) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    if (token == null) {
      return {"success": false, "message": "Token não encontrado. Faça login novamente."};
    }

    final response = await http.post(
      Uri.parse("$_baseUrl/admin/invitations"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({"email": email}),
    );

    if (response.statusCode == 201) {
      return {"success": true, "message": "Convite enviado para $email"};
    } else {
      final body = jsonDecode(response.body);
      return {"success": false, "message": body["message"] ?? "Erro inesperado"};
    }
  }
}
