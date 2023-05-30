import 'package:flutter/material.dart';

import 'app_logo.dart';

class LoadingSliver extends StatelessWidget {
  const LoadingSliver({super.key});

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
            const CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
