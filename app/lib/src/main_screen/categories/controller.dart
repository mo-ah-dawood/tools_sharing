import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'category.dart';
import 'service.dart';

class CategoriesController with ChangeNotifier {
  final CategoriesService _service;
  final TickerProvider vsync;
  late TabController _controller;
  DateTime? _lastupdated;
  DateTime? get lastupdated => _lastupdated;
  TabController get controller => _controller;

  CategoriesController(this._service, this.vsync) {
    _controller = TabController(length: 10, vsync: vsync);
  }

  Iterable<Category> _list = [];
  Iterable<Category> get list => _list;
  StreamSubscription? _subscription;
  void listen() {
    _subscription = _service.stream().listen(_onDataChanged);
  }

  void _onDataChanged(Iterable<Category> event) {
    _list = event;
    _lastupdated = DateTime.now();
    controller.dispose();
    _controller = TabController(length: max(_list.length + 1, 1), vsync: vsync);
    notifyListeners();
  }

  @override
  void dispose() {
    controller.dispose();
    _subscription?.cancel();
    super.dispose();
  }
}
