import 'document_model.dart';

class PsychologistModel {
  final String id;
  final String psychologist;
  final String crp;
  final String speciality;
  final String bio;
  final String status;
  // final String? verifiedAt;
  final List<DocumentModel> documents;

  PsychologistModel({
    required this.id,
    required this.psychologist,
    required this.crp,
    required this.speciality,
    required this.bio,
    required this.status,
    // this.verifiedAt,
    required this.documents,
  });

  factory PsychologistModel.fromJson(Map<String, dynamic> json) {
    return PsychologistModel(
      id: json['id'] ?? '',
      psychologist: json['psychologist'] ?? '',
      crp: json['crp'] ?? '',
      speciality: json['speciality'] ?? '',
      bio: json['bio'] ?? '',
      status: json['status'] ?? '',
      // verifiedAt: json['verified_at'],
      documents: json['documents'] is List
          ? (json['documents'] as List)
              .map((d) => DocumentModel.fromJson(d))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'psychologist': psychologist,
      'crp': crp,
      'speciality': speciality,
      'bio': bio,
      'status': status,
      // 'verified_at': verifiedAt,
      'documents': documents.map((d) => d.toJson()).toList(),
    };
  }
}
