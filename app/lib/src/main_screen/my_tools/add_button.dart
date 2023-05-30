import 'package:flutter/material.dart';
import 'package:tools_sharing/src/main_screen/shopping_cart_button.dart';

import 'manage_item/view.dart';

class AddButton extends StatelessWidget {
  const AddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: DefaultTabController.of(context),
      builder: _build,
    );
  }

  Widget _build(BuildContext context, _) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _builder(context),
    );
  }

  Widget _builder(BuildContext context) {
    if (DefaultTabController.of(context).index == 0) {
      return const ShoppingCartButton();
    }
    if (DefaultTabController.of(context).index != 1) {
      return const SizedBox();
    }
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).pushNamed(ManageTool.routeName);
      },
      child: const Icon(Icons.add_rounded),
    );
  }
}
