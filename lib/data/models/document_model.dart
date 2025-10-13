class DocumentModel {
  final String id;
  final String type;
  final String status;
  final String? reviewedBy;
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
      reviewedBy: json['reviewed_by'],
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
      'reviewed_by': reviewedBy,
      'reviewed_at': reviewedAt,
      'rejection_reason': rejectionReason,
      'created_at': createdAt,
      'temporary_url': temporaryUrl,
    };
  }
}
