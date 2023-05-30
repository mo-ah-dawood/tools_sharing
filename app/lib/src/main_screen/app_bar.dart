import 'package:flutter/material.dart';

import '../localization/app_localizations.dart';
import 'categories/categories_view.dart';
import '../auth/edit_profile.dart';
import 'main_screen.dart';
import 'user_name.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: DefaultTabController.of(context),
      builder: (context, _) {
        return SliverAppBar(
          title: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _title(context),
          ),
          pinned: true,
          floating: true,
          centerTitle: false,
          actions: [
            if (DefaultTabController.of(context).index != 0) ...[
              const EditProfileButton(),
              const SizedBox(width: 15)
            ],
          ],
          bottom: CategoriesView(
            controller: MainScreenView.categories(context),
            show: DefaultTabController.of(context).index == 0,
          ),
        );
      },
    );
  }

  Widget _title(BuildContext context) {
    if (DefaultTabController.of(context).index == 0) {
      return TextField(
        controller: MainScreenView.controller(context),
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context).search,
          border: InputBorder.none,
        ),
      );
    }
    return const UserName();
  }
}
