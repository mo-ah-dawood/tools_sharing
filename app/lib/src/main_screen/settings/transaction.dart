// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;

enum TransactionType { charge, pay, paid, withdraw }

class Transaction {
  final String id;
  final String reference;
  final double value;
  final TransactionType type;
  final Timestamp date;
  final String userId;

  Transaction({
    required this.id,
    required this.reference,
    required this.value,
    required this.type,
    required this.date,
    required this.userId,
  });

  Transaction copyWith({
    String? id,
    String? reference,
    double? value,
    TransactionType? type,
    Timestamp? date,
    String? userId,
  }) {
    return Transaction(
      id: id ?? this.id,
      reference: reference ?? this.reference,
      value: value ?? this.value,
      type: type ?? this.type,
      date: date ?? this.date,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'reference': reference,
      'value': value,
      'type': type.name,
      'date': Timestamp.fromDate(date.toDate().toUtc()),
      'userId': userId,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'] ?? "",
      reference: map['reference'] ?? "",
      value: double.tryParse(map['value']?.toString() ?? "") ?? 0,
      type: TransactionType.values.byName(map['type'] ?? ''),
      date: map['date'],
      userId: map['userId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Transaction.fromJson(String source) =>
      Transaction.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Transaction(id: $id, reference: $reference, value: $value, type: $type, date: $date)';
  }

  @override
  bool operator ==(covariant Transaction other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.reference == reference &&
        other.value == value &&
        other.type == type &&
        other.date == date &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        reference.hashCode ^
        value.hashCode ^
        type.hashCode ^
        date.hashCode ^
        userId.hashCode;
  }
}
