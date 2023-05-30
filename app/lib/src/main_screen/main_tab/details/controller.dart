import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ready_extensions/ready_extensions.dart';
import '../../orders/cart_controller.dart';
import '../../orders/order_item.dart';
import '../../tools/tool_item.dart';
import '../../tools/service.dart';

class ToolDetailsController with ChangeNotifier {
  final ToolsService _service;
  final CartController cart;
  final VoidCallback onItemRentChanged;
  ToolDetailsController(
      this._service, this._model, this.cart, this.onItemRentChanged) {
    cart.addListener(_onCartChanged);
    _onCartChanged();
    _instialOrderItem = _orderItem;
  }

  OrderItem? _instialOrderItem;
  OrderItem? _orderItem;
  OrderItem get orderItem =>
      _orderItem ??
      OrderItem(
        dayPrice: _model.dayPrice,
        toolId: _model.id,
        userId: _model.userId,
        days: 0,
      );
  Tool _model;
  Tool get model => _model;
  bool get changed => _instialOrderItem != _orderItem;
  StreamSubscription? _subscription;
  void listen() {
    _subscription?.cancel();
    _subscription = _service.tool(_model).listen(_onDataChanged);
  }

  void _onDataChanged(Tool event) {
    if (event.isRented != _model.isRented) {
      _model = event;
      onItemRentChanged();
    } else {
      _model = event;
    }
    notifyListeners();
  }

  void _onCartChanged() {
    var cartItem =
        cart.items.firstOrDefault((element) => element.toolId == _model.id);

    if (cartItem != _orderItem) {
      _orderItem = cartItem;
      notifyListeners();
    }
  }

  void add() {
    var item = _orderItem;
    if (item == null) {
      cart.add(orderItem.copyWith(days: 1));
    } else {
      cart.update(item.copyWith(days: item.days + 1));
    }
  }

  void remove() {
    var item = _orderItem;
    if (item == null) return;
    if (item.days <= 0) return;
    if (item.days == 1) {
      cart.remove(item);
    } else {
      cart.update(item.copyWith(days: item.days - 1));
    }
  }

  @override
  void dispose() {
    cart.removeListener(_onCartChanged);
    _subscription?.cancel();
    super.dispose();
  }
}
