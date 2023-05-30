import 'package:flutter/material.dart';
import 'package:ready_extensions/ready_extensions.dart';
import 'package:ready_form/ready_form.dart';

import '../app.dart';
import '../localization/app_localizations.dart';
import '../shared/no_items_found.dart';
import '../shared/remote_builder.dart';
import 'orders/cart_controller.dart';
import 'orders/order_item.dart';
import 'tools/service.dart';
import 'tools/tool_item.dart';

class ShoppingCartScreen extends StatelessWidget {
  static const routeName = '/ShoppingCart';
  const ShoppingCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var ctrl = ModalRoute.of(context)?.settings.arguments as CartController;
    return Scaffold(
      appBar: AppBar(),
      body: ListenableBuilder(
        listenable: ctrl,
        builder: (context, _) {
          if (ctrl.items.isEmpty) {
            return CustomScrollView(
              slivers: [
                NoItemsFound(label: AppLocalizations.of(context).pleaseAddTools)
              ],
            );
          }
          return Center(
            child: ListView(
              padding: const EdgeInsets.all(20),
              shrinkWrap: true,
              children: [
                _total(ctrl, context),
                for (var item in ctrl.items) _item(context, item),
                const SizedBox(height: 50),
                ProgressButton(
                  onPressed: () => ctrl.checkout(context),
                  child: Text(AppLocalizations.of(context).completeOrders),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _item(BuildContext context, OrderItem item) {
    return Card(
      margin: const EdgeInsets.only(top: 10),
      child: ListTile(
        trailing: Text(
          "${item.price.noTrailing()} ${AppLocalizations.of(context).currencyDisplay}",
          textAlign: TextAlign.center,
          style: Theme.of(context).extension<AppStyles>()?.price,
        ),
        subtitle: Text("${AppLocalizations.of(context).days} (${item.days})"),
        title: RemoteBuilder(
          collection: ToolsService.collection,
          mapper: Tool.fromMap,
          builder: (Tool data) {
            return Text(data.name);
          },
          id: item.toolId,
        ),
        // subtitle: ,
      ),
    );
  }

  Widget _total(CartController ctrl, BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
        child: FittedBox(
          child: Text(
            "${ctrl.totalPrice.noTrailing()} ${AppLocalizations.of(context).currencyDisplay}",
            textAlign: TextAlign.center,
            style: Theme.of(context).extension<AppStyles>()?.pricVeryLarge,
          ),
        ),
      ),
    );
  }
}
