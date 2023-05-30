import 'dart:async';
import 'package:flutter/material.dart';
import '../../auth/user.dart';
import '../categories/category.dart';
import '../tools/tool_item.dart';
import '../tools/service.dart';

class ToolsController with ChangeNotifier {
  final ToolsService _service;
  ToolsController(this._service);
  DateTime? _lastUpdate;
  DateTime? get lastUpdate => _lastUpdate;
  Iterable<Tool> _list = [];
  Iterable<Tool> get list => _list;
  StreamSubscription? _subscription;
  void listen(Category? category, UserModel? user) {
    _subscription?.cancel();
    _subscription = _service.stream(category, user).listen(_onDataChanged);
  }

  void _onDataChanged(Iterable<Tool> event) {
    _list = event;
    _lastUpdate = DateTime.now();
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
