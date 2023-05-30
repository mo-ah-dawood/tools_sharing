import 'package:flutter/material.dart';

import 'main_screen.dart';
import 'shopping_cart_screen.dart';

class ShoppingCartButton extends StatelessWidget {
  const ShoppingCartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: MainScreenView.cart(context),
      builder: (context, _) {
        return FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(ShoppingCartScreen.routeName,
                arguments: MainScreenView.cart(context));
          },
          child: Badge.count(
            count: MainScreenView.cart(context).items.length,
            child: const Icon(Icons.shopping_cart),
          ),
        );
      },
    );
  }
}
