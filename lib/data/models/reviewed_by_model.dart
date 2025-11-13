class ReviewedByModel {
  final String id;
  final String name;

  ReviewedByModel({
    required this.id,
    required this.name,
  });

  factory ReviewedByModel.fromJson(Map<String, dynamic> json) {
    return ReviewedByModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
