import 'package:flutter/material.dart';
import 'extensions.dart';

class GoogleButton extends StatelessWidget {
  final String label;
  final Future Function() onPressed;
  const GoogleButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => _call(context),
      icon: const ImageIcon(
        AssetImage(
          'assets/images/google-logo.png',
        ),
        size: 15,
      ),
      label: FittedBox(child: Text(label)),
    );
  }

  void _call(BuildContext context) {
    context.showLoading(onPressed);
  }
}
