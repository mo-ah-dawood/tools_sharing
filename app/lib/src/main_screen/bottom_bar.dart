import 'package:flutter/material.dart';
import 'package:tools_sharing/src/localization/app_localizations.dart';

class MainBottomBar extends StatelessWidget {
  const MainBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: DefaultTabController.of(context),
      builder: (BuildContext context, Widget? child) {
        return NavigationBar(
          selectedIndex: DefaultTabController.of(context).index,
          onDestinationSelected: (value) {
            DefaultTabController.of(context).index = value;
          },
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.construction_rounded),
              label: AppLocalizations.of(context).tools,
            ),
            NavigationDestination(
              icon: const Icon(Icons.precision_manufacturing_rounded),
              label: AppLocalizations.of(context).myTools,
            ),
            NavigationDestination(
              icon: const Icon(Icons.inventory_rounded),
              label: AppLocalizations.of(context).orders,
            ),
            NavigationDestination(
              icon: const Icon(Icons.settings_rounded),
              label: AppLocalizations.of(context).more,
            ),
          ],
        );
      },
    );
  }
}
