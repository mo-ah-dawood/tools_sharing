import 'dart:async';

import 'package:flutter/material.dart';

import '../../auth/auth_controller.dart';
import 'transaction.dart';
import 'wallet_service.dart';

class Walletontroller with ChangeNotifier {
  final WalletService _service;
  final AuthController authController;
  Walletontroller(this._service, this.authController) {
    authController.addListener(_onUserChanged);
    listen();
  }
  Iterable<Transaction> _list = [];
  Iterable<Transaction> get items => _list;
  StreamSubscription? _subscription;
  double get wallet => _list.fold(
      0.0, (previousValue, element) => previousValue + element.value);
  void listen() {
    _subscription?.cancel();
    _subscription =
        _service.stream(authController.user!).listen(_onDataChanged);
  }

  void _onDataChanged(Iterable<Transaction> event) {
    _list = event;
    notifyListeners();
  }

  Future charge(BuildContext context, double value) async {
    await _service.charge(authController.user!, value);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _onUserChanged() {
    authController.removeListener(_onUserChanged);
    listen();
  }
}
