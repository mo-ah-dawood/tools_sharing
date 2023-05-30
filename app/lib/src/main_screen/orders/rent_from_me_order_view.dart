import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:ready_extensions/ready_extensions.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app.dart';
import '../../auth/auth_service.dart';
import '../../auth/user.dart';
import '../../localization/app_localizations.dart';
import '../../shared/remote_builder.dart';
import '../tools/service.dart';
import '../tools/tool_item.dart';
import 'item_progress.dart';
import 'order_item.dart';
import 'service.dart';

class RentedFromMeView extends StatelessWidget {
  const RentedFromMeView({
    super.key,
    required this.item,
  });

  final Order item;

  @override
  Widget build(BuildContext context) {
    var user = MyApp.auth(context).user!;
    var items = item.items.where((w) => w.userId == user.id).toList();
    var price = items.fold(0.0, (p, a) => p + a.price);
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => _Details(item: item),
          ));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListTile(
              title: RemoteBuilder(
                  mapper: UserModel.fromMap,
                  collection: AuthService.collection,
                  id: item.userId,
                  builder: (UserModel data) {
                    return Text(data.name);
                  }),
              subtitle: Text(item.date
                  .toDate()
                  .format(context, DateFormat.yMMMEd().pattern!)),
              trailing: Text(
                "${price.noTrailing()} ${AppLocalizations.of(context).currencyDisplay}",
                style: Theme.of(context).extension<AppStyles>()?.pricVeryLarge,
              ),
            ),
            const Divider(thickness: 0.2),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.spaceAround,
              children: items
                  .map((e) => ItemProgress(item: e, startDate: item.date))
                  .toList(),
            ),
            const SizedBox(height: 8)
          ],
        ),
      ),
    );
  }
}

class _Details extends StatelessWidget {
  final Order item;
  const _Details({required this.item});

  @override
  Widget build(BuildContext context) {
    return RemoteBuilder(
      mapper: Order.fromMap,
      collection: OrdersService.collection,
      id: item.id,
      builder: (Order data) {
        var user = MyApp.auth(context).user!;
        var items = data.items.where((w) => w.userId == user.id).toList();
        var price = items.fold(0.0, (p, a) => p + a.price);
        return Scaffold(
          appBar: AppBar(),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _price(price, context),
              _items(context, items),
              _userDetails(context),
            ],
          ),
        );
      },
    );
  }

  Card _price(double price, BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FittedBox(
          child: Text(
            "${price.noTrailing()} ${AppLocalizations.of(context).currencyDisplay}",
            style: Theme.of(context).extension<AppStyles>()?.price,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Card _userDetails(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      child: RemoteBuilder(
        mapper: UserModel.fromMap,
        collection: AuthService.collection,
        id: item.userId,
        builder: (UserModel data) {
          return _TenantData(user: data);
        },
      ),
    );
  }

  Card _items(BuildContext context, List<OrderItem> items) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: items.map((e) => _DetailsItem(order: item, tool: e)).toList(),
      ),
    );
  }
}

class _DetailsItem extends StatelessWidget {
  const _DetailsItem({
    required this.tool,
    required this.order,
  });

  final OrderItem tool;
  final Order order;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      trailing: ItemProgress(
        item: tool,
        startDate: order.date,
      ),
      subtitle: Text(AppLocalizations.of(context)
          .endsAt(tool.enddate(order.date).format24(context))),
      title: RemoteBuilder(
        collection: ToolsService.collection,
        mapper: Tool.fromMap,
        builder: (Tool data) {
          return Text(data.name);
        },
        id: tool.toolId,
      ),
    );
  }
}

class _TenantData extends StatelessWidget {
  final UserModel user;
  const _TenantData({required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        ListTile(
          title: Text(AppLocalizations.of(context).name),
          subtitle: Text(user.name),
        ),
        ListTile(
          onTap: () async {
            var url = "mailto:${user.email}";
            await launchUrl(Uri.parse(url));
          },
          title: Text(AppLocalizations.of(context).email),
          subtitle: Text(user.email),
        ),
        ListTile(
          onTap: user.phone.isEmpty
              ? null
              : () async {
                  var url = "tel:${user.phone}";
                  await launchUrl(Uri.parse(url));
                },
          title: Text(AppLocalizations.of(context).phone),
          subtitle: Text(user.phone),
        ),
        ListTile(
          onTap: user.address == null
              ? null
              : () async {
                  await MapsLauncher.launchCoordinates(
                      user.address!.lat, user.address!.lon);
                },
          title: Text(AppLocalizations.of(context).location),
          subtitle: Text(user.address?.toString() ?? ""),
        ),
      ],
    );
  }
}
