// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;
import 'package:flutter/foundation.dart';

/// A placeholder class that represents an entity or model.
class Order {
  final String id;
  final Timestamp date;
  final bool recieved;
  final String userId;
  final Set<OrderItem> items;
  Order({
    this.id = '',
    required this.date,
    this.recieved = false,
    this.userId = '',
    this.items = const {},
  });

  double get price => items.fold(
      0.0, (previousValue, element) => previousValue + element.price);
  Order withItem(OrderItem item) {
    return copyWith(items: {...withoutItem(item).items, item});
  }

  Order withoutItem(OrderItem item) {
    return copyWith(
        items: items.where((element) => element.toolId != item.toolId).toSet());
  }

  Order copyWith({
    String? id,
    Timestamp? date,
    bool? recieved,
    String? userId,
    Set<OrderItem>? items,
  }) {
    return Order(
      id: id ?? this.id,
      date: date ?? this.date,
      recieved: recieved ?? this.recieved,
      userId: userId ?? this.userId,
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'date': date,
      'recieved': recieved,
      'userId': userId,
      'items': items.map((x) => x.toMap()).toList(),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] ?? '',
      date: map['date'] == null ? Timestamp.now() : map['date'] as Timestamp,
      userId: map['userId'] ?? '',
      recieved: map['recieved'] == true,
      items: (map['items'] as List?)
              ?.map<OrderItem>(
                  (x) => OrderItem.fromMap(x as Map<String, dynamic>))
              .toSet() ??
          {},
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) =>
      Order.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Order(id: $id, date: $date, recieved: $recieved, userId: $userId, items: $items)';
  }

  @override
  bool operator ==(covariant Order other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.date == date &&
        other.recieved == recieved &&
        other.userId == userId &&
        setEquals(other.items, items);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        date.hashCode ^
        recieved.hashCode ^
        userId.hashCode ^
        items.hashCode;
  }
}

class OrderItem {
  final double dayPrice;
  final int days;
  final String toolId;
  final String userId;
  final bool received;
  double get price => dayPrice * days;
  DateTime enddate(Timestamp start) {
    return start.toDate().toLocal().add(Duration(days: days));
  }

  OrderItem({
    required this.dayPrice,
    this.days = 1,
    required this.toolId,
    required this.userId,
    this.received = false,
  });

  OrderItem copyWith({
    double? dayPrice,
    int? days,
    String? toolId,
    String? userId,
    bool? received,
  }) {
    return OrderItem(
      dayPrice: dayPrice ?? this.dayPrice,
      days: days ?? this.days,
      toolId: toolId ?? this.toolId,
      userId: userId ?? this.userId,
      received: received ?? this.received,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dayPrice': dayPrice,
      'days': days,
      'toolId': toolId,
      'userId': userId,
      'received': received,
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      dayPrice: double.tryParse(map['dayPrice']?.toString() ?? '') ?? 0,
      days: map['days'] as int,
      toolId: map['toolId'] ?? "",
      userId: map['userId'] ?? "",
      received: map['received'] == true,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderItem.fromJson(String source) =>
      OrderItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderItem(dayPrice: $dayPrice, days: $days, toolId: $toolId, userId: $userId, received: $received)';
  }

  @override
  bool operator ==(covariant OrderItem other) {
    if (identical(this, other)) return true;

    return other.dayPrice == dayPrice &&
        other.days == days &&
        other.toolId == toolId &&
        other.userId == userId &&
        other.received == received;
  }

  @override
  int get hashCode {
    return dayPrice.hashCode ^
        days.hashCode ^
        toolId.hashCode ^
        userId.hashCode ^
        received.hashCode;
  }
}
