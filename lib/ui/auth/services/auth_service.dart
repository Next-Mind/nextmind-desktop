import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = "https://api-staging.nextmind.tech";

  static Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse("$baseUrl/login");

    final response = await http.post(
      url,
      headers: {
      "Content-Type": "application/json",
      "X-Client": "desktop",
      },
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // retorno da API
    } else {
      throw Exception("Erro ao Fazer Login");
    }
  }
}
