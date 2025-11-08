import 'package:desktop_nextmind/data/models/audit_model.dart';
import 'package:desktop_nextmind/data/service/audit_service.dart';

class AuditRepository {
  final AuditService _service;

  AuditRepository(this._service);

  Future<List<Audit>> getAudits() async {
    try {
      final audits = await _service.fetchAudits();
      return audits;
    } catch (e) {
      rethrow;
    }
  }
}
