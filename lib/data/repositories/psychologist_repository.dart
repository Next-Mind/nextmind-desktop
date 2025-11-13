import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/psychologist_model.dart';

class PsychologistRepository {
  final String token;

  PsychologistRepository({required this.token});

  Future<PsychologistModel> fetchPsychologistById(String psychologistId) async {
    final url = Uri.parse('https://api.nextmind.sbs/psychologists/$psychologistId');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return PsychologistModel.fromJson(data);
    } else {
      throw Exception(
        'Erro ao carregar dados do psicólogo (${response.statusCode})',
      );
    }
  }
}
