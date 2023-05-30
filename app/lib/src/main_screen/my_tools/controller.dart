import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tools_sharing/src/auth/user.dart';

import '../tools/service.dart';
import '../tools/tool_item.dart';

class MyToolsController with ChangeNotifier {
  final ToolsService _service;
  MyToolsController(this._service);
  DateTime? _lastUpdate;
  DateTime? get lastUpdate => _lastUpdate;
  Iterable<Tool> _list = [];
  Iterable<Tool> get list => _list;
  StreamSubscription? _subscription;
  void listen(UserModel user) {
    _subscription?.cancel();
    _subscription = _service.myToolsStream(user).listen(_onDataChanged);
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
