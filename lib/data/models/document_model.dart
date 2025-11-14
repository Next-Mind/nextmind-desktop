import 'package:desktop_nextmind/data/models/reviewed_by_model.dart';

class DocumentModel {
  final String id;
  final String type;
  final String status;
  final ReviewedByModel? reviewedBy;
  final String? reviewedAt;
  final String? rejectionReason;
  final String createdAt;
  final String temporaryUrl;

  DocumentModel({
    required this.id,
    required this.type,
    required this.status,
    this.reviewedBy,
    this.reviewedAt,
    this.rejectionReason,
    required this.createdAt,
    required this.temporaryUrl,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      id: json['id'] ?? '',
      type: json['type'] ?? '',
      status: json['status'] ?? '',
      reviewedBy: json['reviewed_by'] != null
          ? ReviewedByModel.fromJson(json['reviewed_by'])
          : null,
      reviewedAt: json['reviewed_at'],
      rejectionReason: json['rejection_reason'],
      createdAt: json['created_at'] ?? '',
      temporaryUrl: json['temporary_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'status': status,
      'reviewed_by': reviewedBy?.toJson(),
      'reviewed_at': reviewedAt,
      'rejection_reason': rejectionReason,
      'created_at': createdAt,
      'temporary_url': temporaryUrl,
    };
  }

  DocumentModel copyWith({
    String? id,
    String? type,
    String? status,
    ReviewedByModel? reviewedBy,
    String? reviewedAt,
    String? rejectionReason,
    String? createdAt,
    String? temporaryUrl,
  }) {
    return DocumentModel(
      id: id ?? this.id,
      type: type ?? this.type,
      status: status ?? this.status,
      reviewedBy: reviewedBy ?? this.reviewedBy,
      reviewedAt: reviewedAt ?? this.reviewedAt,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      createdAt: createdAt ?? this.createdAt,
      temporaryUrl: temporaryUrl ?? this.temporaryUrl,
    );
  }
}
