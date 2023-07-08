import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ready_extensions/ready_extensions.dart';

import '../../auth/auth_controller.dart';
import '../../localization/app_localizations.dart';
import '../settings/wallet_controller.dart';
import '../tools/service.dart';
import 'order_item.dart';
import 'service.dart';

class CartController with ChangeNotifier {
  final OrdersService service;
  final ToolsService tools;
  final AuthController authController;
  final Walletontroller walletController;
  CartController({
    required this.service,
    required this.authController,
    required this.tools,
    required this.walletController,
  }) {
    authController.addListener(_onUserChanged);
    listen();
  }
  Order? _model;
  Set<OrderItem> get items => _model?.items ?? {};
  StreamSubscription? _subscription;
  StreamSubscription? _subscription2;
  double get totalPrice => _model?.price ?? 0;
  void listen() {
    _subscription?.cancel();
    if (authController.user != null) {
      _subscription =
          service.myCart(authController.user!).listen(_onDataChanged);
    }
  }

  void _listenTools() {
    _subscription2?.cancel();
    _subscription2 = tools.rentedStream().listen(_onrentedChanged);
  }

  void _onrentedChanged(Iterable<String> event) {
    var tool = items.firstOrDefault((a) => event.any((b) => a.toolId == b));
    if (tool != null) {
      remove(tool);
    }
  }

  Future add(OrderItem item) async {
    if (_model == null) {
      await service.generateCart(authController.user!);
    }
    await service.addToCart(_model!, item);
  }

  Future update(OrderItem item) async {
    if (_model == null) {
      await service.generateCart(authController.user!);
    }
    await service.updateInCart(_model!, item);
  }

  Future remove(OrderItem item) async {
    if (_model == null) {
      await service.generateCart(authController.user!);
    }
    await service.removeFromCart(_model!, item);
  }

  void _onDataChanged(Order? event) {
    _model = event;
    _listenTools();
    notifyListeners();
  }

  Future checkout(BuildContext context) async {
    if (_model == null || items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context).pleaseAddTools)));
      return;
    }
    var price = _model!.price;
    if (walletController.wallet < price) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context).youShouldChargeWallet)));
      return;
    }
    await service.checkOut(_model!);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
        content: Text(AppLocalizations.of(context).successFullyAddedTheOrder),
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
            },
            child: Text(AppLocalizations.of(context).gotIt),
          )
        ],
      ));
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _subscription2?.cancel();
    super.dispose();
  }

  void _onUserChanged() {
    authController.removeListener(_onUserChanged);
    listen();
  }
}
