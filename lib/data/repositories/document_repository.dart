import 'dart:typed_data';
import 'package:http/http.dart' as http;

class DocumentRepository {
  final String token;

  DocumentRepository({required this.token});

  Future<Uint8List> fetchPdfBytes(String temporaryUrl) async {
    final response = await http.get(
      Uri.parse(temporaryUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/pdf',
      },
    );

    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Erro ao carregar PDF (${response.statusCode})');
    }
  }
}
