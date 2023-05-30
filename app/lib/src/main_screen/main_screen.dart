import 'package:flutter/material.dart';

import '../app.dart';
import '../auth/auth_controller.dart';
import '../auth/login_view.dart';
import 'app_bar.dart';
import 'bottom_bar.dart';
import 'categories/controller.dart';
import 'categories/service.dart';
import 'main_tab/view.dart';
import 'my_tools/add_button.dart';
import 'my_tools/view.dart';
import 'orders/cart_controller.dart';
import 'orders/service.dart';
import 'orders/view.dart';
import 'settings/settings_tab.dart';
import 'settings/wallet_controller.dart';
import 'settings/wallet_service.dart';
import 'tools/service.dart';

class MainScreenView extends StatefulWidget {
  const MainScreenView({super.key});

  static const routeName = '/Main';

  @override
  State<MainScreenView> createState() => _MainScreenViewState();

  static TextEditingController controller(BuildContext context) =>
      context.findAncestorStateOfType<_MainScreenViewState>()!.controller;

  static CategoriesController categories(BuildContext context) =>
      context.findAncestorStateOfType<_MainScreenViewState>()!.categories;

  static Walletontroller wallet(BuildContext context) =>
      context.findAncestorStateOfType<_MainScreenViewState>()!.wallet;
  static CartController cart(BuildContext context) =>
      context.findAncestorStateOfType<_MainScreenViewState>()!.cart;
}

class _MainScreenViewState extends State<MainScreenView>
    with TickerProviderStateMixin {
  late AuthController authController;
  final TextEditingController controller = TextEditingController();
  late final CategoriesController categories =
      CategoriesController(CategoriesService(), this);

  late final Walletontroller wallet;
  late final CartController cart;
  @override
  void didChangeDependencies() {
    authController = MyApp.auth(context);
    authController.addListener(_onUserChanged);
    wallet = Walletontroller(WalletService(), authController);
    cart = CartController(
      service: OrdersService(),
      authController: authController,
      tools: ToolsService(),
      walletController: wallet,
    );

    super.didChangeDependencies();
  }

  void _onUserChanged() {
    if (!mounted) return;
    var ctrl = MyApp.auth(context);
    if (!ctrl.authenticated || !ctrl.emailVerified) {
      authController.removeListener(_onUserChanged);
      Navigator.of(context)
          .pushNamedAndRemoveUntil(LoginView.routeName, (route) => false);
    }
  }

  @override
  void dispose() {
    authController.removeListener(_onUserChanged);
    controller.dispose();
    categories.dispose();
    cart.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        floatingActionButton: const AddButton(),
        bottomNavigationBar: const MainBottomBar(),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              // 1/2 remove this widget and only use SliverAppBar
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: const MainAppBar(),
              ),
            ];
          },
          body: TabBarView(
            children: [
              ToolsTab(controller: categories),
              const MyToolsTab(),
              const OrdersTab(),
              const SettingsTab(),
            ],
          ),
        ),
      ),
    );
  }
}
