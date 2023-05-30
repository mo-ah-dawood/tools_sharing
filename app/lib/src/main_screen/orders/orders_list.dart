import 'package:flutter/material.dart';

import '../../app.dart';
import '../../auth/auth_controller.dart';
import '../../localization/app_localizations.dart';
import '../../shared/loading_sliver.dart';
import '../../shared/no_items_found.dart';
import 'controller.dart';
import 'rent_by_me_order_view.dart';
import 'rent_from_me_order_view.dart';
import 'service.dart';

class OrdersListScreen extends StatefulWidget {
  static const routeName = '/orders';

  const OrdersListScreen({super.key});

  @override
  State<OrdersListScreen> createState() => _OrdersListScreenState();
}

class _OrdersListScreenState extends State<OrdersListScreen> {
  late AuthController auth;
  late OrderController controller;
  @override
  void didChangeDependencies() {
    controller = OrderController(
      OrdersService(),
      ModalRoute.of(context)?.settings.arguments as bool,
    );
    auth = MyApp.auth(context);
    auth.addListener(_onUserChanged);
    controller.addListener(_onChanged);
    controller.listen(auth.user!);
    super.didChangeDependencies();
  }

  void _onChanged() {
    if (mounted) setState(() {});
  }

  void _onUserChanged() {
    if (!auth.authenticated || !auth.emailVerified) {
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    auth.removeListener(_onUserChanged);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var list = controller.list;
    var byMe = ModalRoute.of(context)?.settings.arguments as bool;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(byMe
                ? AppLocalizations.of(context).rentedByMe
                : AppLocalizations.of(context).rentedFromMe),
          ),
          if (controller.lastUpdate == null)
            const LoadingSliver()
          else if (list.isEmpty && controller.lastUpdate != null)
            if (byMe)
              NoItemsFound(
                  label: AppLocalizations.of(context).youDontMakeAnyOrder)
            else
              NoItemsFound(
                  label: AppLocalizations.of(context).noOneOrderedFromYou)
          else
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverList.builder(
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  var item = list.elementAt(index);
                  if (byMe) {
                    return RentedByMeView(
                      onReceived: (items) => controller.received(item, items),
                      item: item,
                    );
                  } else {
                    return RentedFromMeView(
                      item: item,
                    );
                  }
                },
              ),
            ),
        ],
      ),
    );
  }
}
