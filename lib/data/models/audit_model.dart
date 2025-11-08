import 'package:flutter/material.dart';

class Audit {
  final String id;
  final String event;
  final String? auditableType;
  final String? createdAt;
  final AuditUser? user;
  final AuditNewValues? newValues;

  Audit({
    required this.id,
    required this.event,
    this.auditableType,
    this.createdAt,
    this.user,
    this.newValues,
  });

  factory Audit.fromJson(Map<String, dynamic> json) {
    return Audit(
      id: json['id'],
      event: json['event'],
      auditableType: json['auditable_type'],
      createdAt: json['created_at'],
      user: json['user'] != null ? AuditUser.fromJson(json['user']) : null,
      newValues: json['new_values'] != null
          ? AuditNewValues.fromJson(json['new_values'])
          : null,
    );
  }

  String get readableMessage {
    final actor = user?.name ?? "Um usuário";
    final target = newValues?.name ?? "um registro";

    final Map<String, String Function()> messages = {
      'appointments.created': () => "$actor criou uma nova consulta.",
      'appointments.updated': () => "$actor atualizou os dados de uma consulta.",
      'appointments.deleted': () => "$actor excluiu uma consulta.",

      'post.created': () => "$actor criou uma nova postagem.",
      'post.updated': () => "$actor atualizou uma postagem existente.",
      'post.deleted': () => "$actor excluiu uma postagem.",

      'availability.created': () => "$actor adicionou uma nova disponibilidade.",
      'availability.updated': () => "$actor atualizou uma disponibilidade.",
      'availability.deleted': () => "$actor removeu uma disponibilidade.",

      'users.logged_in': () => "$actor fez login no sistema.",
      'users.created': () => "Um novo usuário foi criado ($target).",
      'users.updated': () => "$target atualizou suas informações",
      'users.deleted': () => "$target excluiu sua conta.",
    };
    return messages[event]?.call() ?? "$actor realizou a ação: $event.";
  }

  IconData get eventIcon {
    const Map<String, IconData> icons = {
      'appointments.created': Icons.event_available,
      'appointments.updated': Icons.event_note,
      'appointments.deleted': Icons.event_busy,

      'post.created': Icons.post_add,
      'post.updated': Icons.edit_note,
      'post.deleted': Icons.delete_forever,

      'availability.created': Icons.schedule,
      'availability.updated': Icons.schedule_send,
      'availability.deleted': Icons.schedule_outlined,

      'users.logged_in': Icons.login,
      'users.created': Icons.person_add_alt_1,
      'users.updated': Icons.manage_accounts,
      'users.deleted': Icons.person_remove_alt_1,
    };

    return icons[event] ?? Icons.info_outline;
  }

  Color get eventColor {
    if (event.contains('.created')) return Colors.green;
    if (event.contains('.updated')) return Colors.blue;
    if (event.contains('.deleted')) return Colors.red;
    if (event.contains('logged_in')) return Colors.teal;
    if (event.contains('approved')) return Colors.green;
    if (event.contains('repproved')) return Colors.red;
    if (event.contains('uploaded')) return Colors.orange;
    return Colors.black54;
  }
}

class AuditUser {
  final String id;
  final String name;
  final String email;
  final String? photoUrl;

  AuditUser({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
  });

  factory AuditUser.fromJson(Map<String, dynamic> json) {
    return AuditUser(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      photoUrl: json['photo_url'],
    );
  }
}

class AuditNewValues {
  final String? name;
  final String? email;
  final String? title;
  final String? imageUrl;

  AuditNewValues({
    this.name,
    this.email,
    this.title,
    this.imageUrl,
  });

  factory AuditNewValues.fromJson(Map<String, dynamic> json) {
    return AuditNewValues(
      name: json['name'],
      email: json['email'],
      title: json['title'],
      imageUrl: json['image_url'],
    );
  }
}
