import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/models/psychologist_model.dart';

class ManagementViewModel extends ChangeNotifier {
  final String baseUrl = "https://api.nextmind.sbs";

  List<PsychologistModel> pending = [];
  Map<String, bool> readStatus = {}; // controla leitura por id
  bool isLoading = false;
  String? error;

  Future<void> fetchPending() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");
      if (token == null) throw Exception("Token não encontrado");

      final url =
          Uri.parse('$baseUrl/admin/psychologists?status=pending&page=1');
      final response = await http.get(url, headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List list = data['data'];
        pending = list.map((e) => PsychologistModel.fromJson(e)).toList();
        for (var p in pending) {
          readStatus[p.id] = false; // inicia como não lido
        }
      } else {
        throw Exception("Erro ao carregar pendentes");
      }
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void markAsRead(String id, bool value) {
    readStatus[id] = value;
    notifyListeners();
  }

  bool isRead(String id) => readStatus[id] ?? false;

  Future<void> approvePsychologist(PsychologistModel p) async {
    if (p.documents.isEmpty) throw Exception("Documento não encontrado");
    final docId = p.documents[0].id;

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    if (token == null) throw Exception("Token não encontrado");

    final url =
        Uri.parse('$baseUrl/admin/psychologists/documents/$docId/approve');

    final response = await http.patch(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      pending.removeWhere((e) => e.id == p.id);
      notifyListeners();
    } else {
      throw Exception("Erro ao aprovar psicólogo");
    }
  }

  Future<void> rejectPsychologist(PsychologistModel p,
      {bool skipDocumentCheck = false}) async {
    if (!skipDocumentCheck && p.documents.isEmpty)
      throw Exception("Documento não encontrado");

    if (p.documents.isEmpty) {
      pending.removeWhere((e) => e.id == p.id);
      notifyListeners();
      return;
    }

    final docId = p.documents[0].id;

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    if (token == null) throw Exception("Token não encontrado");

    final url =
        Uri.parse('$baseUrl/admin/psychologists/documents/$docId/repprove');

    final response = await http.patch(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      pending.removeWhere((e) => e.id == p.id);
      notifyListeners();
    } else {
      throw Exception("Erro ao reprovar psicólogo");
    }
  }
}
