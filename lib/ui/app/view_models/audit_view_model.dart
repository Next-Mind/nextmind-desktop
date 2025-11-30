import 'package:desktop_nextmind/data/service/audit_service.dart';
import 'package:flutter/material.dart';
import '../../../data/models/audit_model.dart';

class AuditViewModel extends ChangeNotifier {
  final AuditService _service = AuditService();
  List<Audit> _audits = [];
  bool _isLoading = false;
  String? _error;

  List<Audit> get audits => _audits;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadAudits() async {
    _isLoading = true;
    notifyListeners();
    try {
      _audits = await _service.fetchAudits();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
