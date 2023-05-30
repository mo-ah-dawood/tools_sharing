// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;

/// A placeholder class that represents an entity or model.
class Tool {
  final String id;
  final String name;
  final String image;
  final String description;
  final double dayPrice;
  final String userId;
  final String condition;
  final String manufacture;
  final String categoryId;
  final Timestamp? endDate;
  bool get isRented {
    if (endDate == null) return false;
    return !endDate!.toDate().toUtc().isBefore(DateTime.now().toUtc());
  }

  Tool({
    this.id = '',
    required this.name,
    required this.image,
    required this.description,
    required this.dayPrice,
    required this.userId,
    required this.categoryId,
    this.endDate,
    this.condition = '',
    this.manufacture = '',
  });

  @override
  bool operator ==(covariant Tool other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.image == image &&
        other.description == description &&
        other.dayPrice == dayPrice &&
        other.userId == userId &&
        other.condition == condition &&
        other.manufacture == manufacture &&
        other.categoryId == categoryId &&
        other.endDate == endDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        image.hashCode ^
        description.hashCode ^
        dayPrice.hashCode ^
        userId.hashCode ^
        condition.hashCode ^
        manufacture.hashCode ^
        categoryId.hashCode ^
        endDate.hashCode;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'description': description,
      'dayPrice': dayPrice,
      'userId': userId,
      'condition': condition,
      'manufacture': manufacture,
      'categoryId': categoryId,
      'endDate': endDate,
    };
  }

  factory Tool.fromMap(Map<String, dynamic> map) {
    return Tool(
      id: map['id'] ?? "",
      name: map['name'] ?? "",
      image: map['image'] ?? "",
      description: map['description'] ?? "",
      dayPrice: double.tryParse(map['dayPrice']?.toString() ?? '') ?? 0,
      userId: map['userId'] ?? "",
      categoryId: map['categoryId'] ?? "",
      endDate: map['endDate'],
      manufacture: map['manufacture'] ?? '',
      condition: map['condition'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Tool.fromJson(String source) =>
      Tool.fromMap(json.decode(source) as Map<String, dynamic>);

  Tool copyWith({
    String? id,
    String? name,
    String? image,
    String? description,
    double? dayPrice,
    String? userId,
    String? condition,
    String? manufacture,
    String? categoryId,
    Timestamp? endDate,
  }) {
    return Tool(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      description: description ?? this.description,
      dayPrice: dayPrice ?? this.dayPrice,
      userId: userId ?? this.userId,
      condition: condition ?? this.condition,
      manufacture: manufacture ?? this.manufacture,
      categoryId: categoryId ?? this.categoryId,
      endDate: endDate ?? this.endDate,
    );
  }

  @override
  String toString() {
    return 'Tool(id: $id, name: $name, image: $image, description: $description, dayPrice: $dayPrice, userId: $userId, categoryId: $categoryId, endDate: $endDate)';
  }
}
