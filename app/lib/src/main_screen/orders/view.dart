import 'package:flutter/material.dart';
import 'package:tools_sharing/src/localization/app_localizations.dart';

import '../../shared/app_logo.dart';
import 'orders_list.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
          const SliverToBoxAdapter(child: SizedBox(height: 50)),
          const SliverToBoxAdapter(child: Center(child: AppLogo.horizontal())),
          const SliverToBoxAdapter(child: SizedBox(height: 50)),
          _item(
            context: context,
            title: AppLocalizations.of(context).rentedByMe,
            icon: Icons.download_rounded,
            onPresssed: () {
              Navigator.of(context)
                  .pushNamed(OrdersListScreen.routeName, arguments: true);
            },
          ),
          _item(
            context: context,
            title: AppLocalizations.of(context).rentedFromMe,
            icon: Icons.upload_rounded,
            onPresssed: () {
              Navigator.of(context)
                  .pushNamed(OrdersListScreen.routeName, arguments: false);
            },
          ),
        ],
      ),
    );
  }

  SliverPadding _item({
    required BuildContext context,
    required String title,
    required IconData icon,
    required VoidCallback onPresssed,
  }) {
    return SliverPadding(
      padding: const EdgeInsets.all(20),
      sliver: SliverToBoxAdapter(
        child: Card(
          child: InkWell(
            onTap: onPresssed,
            child: AspectRatio(
              aspectRatio: 2 / 1,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: FittedBox(child: Icon(icon)),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
