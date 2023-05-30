import 'package:flutter/material.dart';

import '../localization/app_localizations.dart';
import 'app_logo.dart';

class NoItemsFound extends StatelessWidget {
  final String? label;
  const NoItemsFound({super.key, this.label});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppLogo(
              addHero: false,
              logo: Logo.icon,
              color: Theme.of(context).colorScheme.primary,
              constraints: const BoxConstraints(maxWidth: 100),
            ),
            const SizedBox(height: 20),
            Text(
              label ?? AppLocalizations.of(context).noToolsFound,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            )
          ],
        ),
      ),
    );
  }
}
