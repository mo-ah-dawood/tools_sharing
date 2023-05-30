import 'dart:async';

import 'package:flutter/material.dart';

import '../../auth/user.dart';
import 'order_item.dart';
import 'service.dart';

class OrderController with ChangeNotifier {
  final OrdersService _service;
  final bool byMe;
  OrderController(this._service, this.byMe);
  Iterable<Order> _list = [];
  Iterable<Order> get list => _list;
  StreamSubscription? _subscription;
  DateTime? _lastUpdate;
  DateTime? get lastUpdate => _lastUpdate;
  void listen(UserModel user) {
    _subscription?.cancel();
    _subscription = _service.stream(user, byMe).listen(_onDataChanged);
  }

  void _onDataChanged(Iterable<Order> event) {
    _list = event;
    _lastUpdate = DateTime.now();
    notifyListeners();
  }

  Future received(Order order, List<OrderItem> items) async {
    await _service.setRecieved(order, items);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
