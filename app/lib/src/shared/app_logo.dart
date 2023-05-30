import 'package:flutter/material.dart';

enum Logo { icon, horizontal, vertical }

class AppLogo extends StatelessWidget {
  final Logo logo;
  final BoxConstraints? constraints;
  final bool addHero;
  final Color? color;
  const AppLogo({
    super.key,
    this.logo = Logo.icon,
    this.constraints,
    this.addHero = true,
    this.color,
  });

  const AppLogo.horizontal({
    super.key,
    this.addHero = true,
    this.color,
  })  : logo = Logo.horizontal,
        constraints = const BoxConstraints(maxWidth: 250);

  @override
  Widget build(BuildContext context) {
    if (!addHero) return _child(context);
    return Hero(
      tag: 'logo',
      child: Material(
        type: MaterialType.transparency,
        child: _child(context),
      ),
    );
  }

  Widget _child(BuildContext context) {
    if (constraints == null) {
      return _builder(context);
    } else {
      return ConstrainedBox(
        constraints: constraints!,
        child: _builder(context),
      );
    }
  }

  Widget _builder(BuildContext context) {
    return switch (logo) {
      Logo.icon => Image.asset(
          "assets/images/02.png",
          color: color,
          colorBlendMode: BlendMode.srcIn,
        ),
      Logo.horizontal => Image.asset(
          "assets/images/04.png",
          color: color,
          colorBlendMode: BlendMode.srcIn,
        ),
      Logo.vertical => Image.asset(
          "assets/images/01.png",
          color: color,
          colorBlendMode: BlendMode.srcIn,
        ),
    };
  }
}
