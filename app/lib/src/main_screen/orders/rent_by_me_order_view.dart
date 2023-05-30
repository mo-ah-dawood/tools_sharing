import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:ready_extensions/ready_extensions.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app.dart';
import '../../auth/auth_service.dart';
import '../../auth/user.dart';
import '../../localization/app_localizations.dart';
import '../../shared/extensions.dart';
import '../../shared/remote_builder.dart';
import '../tools/service.dart';
import '../tools/tool_item.dart';
import 'item_progress.dart';
import 'order_item.dart';
import 'service.dart';

class RentedByMeView extends StatelessWidget {
  final Future Function(List<OrderItem> items) onReceived;
  const RentedByMeView(
      {super.key, required this.item, required this.onReceived});

  final Order item;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => _Details(item: item, onReceived: onReceived),
          ));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListTile(
              title: Text(item.date
                  .toDate()
                  .format(context, DateFormat.yMMMEd().pattern!)),
              trailing: Text(
                "${item.price.noTrailing()} ${AppLocalizations.of(context).currencyDisplay}",
                style: Theme.of(context).extension<AppStyles>()?.pricVeryLarge,
              ),
            ),
            const Divider(thickness: 0.2),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.spaceAround,
              children: item.items
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
  final Future Function(List<OrderItem> items) onReceived;
  final Order item;
  const _Details({required this.item, required this.onReceived});

  @override
  Widget build(BuildContext context) {
    return RemoteBuilder(
      mapper: Order.fromMap,
      collection: OrdersService.collection,
      id: item.id,
      builder: (Order data) {
        var groups = data.items.groupListsBy((e) => e.userId);
        return Scaffold(
          appBar: AppBar(),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _price(data, context),
              ...groups.entries
                  .map((e) =>
                      _itemGroup(context: context, order: data, group: e))
                  .toList(),
            ],
          ),
        );
      },
    );
  }

  Card _price(Order data, BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FittedBox(
          child: Text(
            "${data.price.noTrailing()} ${AppLocalizations.of(context).currencyDisplay}",
            style: Theme.of(context).extension<AppStyles>()?.price,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _itemGroup({
    required BuildContext context,
    required Order order,
    required MapEntry<String, List<OrderItem>> group,
  }) {
    var price = group.value.fold(0.0, (p, i) => p + i.price);
    return RemoteBuilder(
        mapper: UserModel.fromMap,
        collection: AuthService.collection,
        id: group.key,
        builder: (UserModel data) {
          return Card(
            margin: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListTile(
                  trailing: Text(
                    "${price.noTrailing()} ${AppLocalizations.of(context).currencyDisplay}",
                    style: Theme.of(context).extension<AppStyles>()?.price,
                  ),
                  title: Text(data.name),
                ),
                const Divider(thickness: 0.3),
                for (var tool in group.value)
                  _DetailsItem(tool: tool, order: order),
                const Divider(thickness: 0.3),
                ButtonBar(
                  children: [
                    if (group.value.any((element) => !element.received))
                      _setRecived(context, group.value),
                    _owerData(context, data),
                  ],
                ),
              ],
            ),
          );
        });
  }

  Widget _setRecived(BuildContext context, List<OrderItem> items) {
    return TextButton(
      onPressed: () => context.showLoading(() => onReceived(items)),
      child: Text(AppLocalizations.of(context).received),
    );
  }

  Widget _owerData(BuildContext context, UserModel user) {
    return TextButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return _OwnerData(user: user);
          },
        );
      },
      child: Text(AppLocalizations.of(context).ownerDetails),
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

class _OwnerData extends StatelessWidget {
  final UserModel user;
  const _OwnerData({required this.user});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
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
          Container(
            alignment: AlignmentDirectional.centerEnd,
            padding: const EdgeInsets.all(10).copyWith(top: 0),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context).back),
            ),
          ),
        ],
      ),
    );
  }
}
