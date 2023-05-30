import 'package:flutter/material.dart';

class PlatformScreen extends StatelessWidget {
  final Widget child;
  const PlatformScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    if (size.width <= 650) return child;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 650),
        child: child,
      ),
    );
  }
}
