import 'dart:math';

import 'package:flutter/material.dart';

import '../auth/auth_controller.dart';
import '../auth/confirm_email_view.dart';
import '../auth/login_view.dart';
import '../main_screen/main_screen.dart';
import '../shared/app_logo.dart';

class SplashView extends StatefulWidget {
  static const routeName = '/';
  final AuthController authController;

  const SplashView({
    Key? key,
    required this.authController,
  }) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  Random rnd = Random();

  void _onFinish(BuildContext context) {
    if (!widget.authController.authenticated) {
      Navigator.of(context).pushReplacementNamed(LoginView.routeName);
    } else if (!widget.authController.emailVerified) {
      Navigator.of(context).pushReplacementNamed(ConfirmEmailView.routeName);
    } else {
      Navigator.of(context).pushReplacementNamed(MainScreenView.routeName);
    }
  }

  Animation<double> generateAnimation(
    double begin,
    double end,
    double from,
    double to,
  ) {
    return Tween(begin: from, end: to).animate(CurvedAnimation(
      parent: controller,
      curve: Interval(begin, end, curve: Curves.easeInCubic),
    ));
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);

    controller.forward().then((d) {
      _onFinish(context);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          for (var i = 0; i < 10; i++)
            for (var x = 0; x < 10; x++)
              buildLogoPart(i == 0 ? 0 : i / 10, x == 0 ? 0 : x / 10),
        ],
      ),
    );
  }

  Widget buildLogoPart(double top, double left) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    var angle = rnd.nextInt(10);
    var t = rnd.nextInt((h * 2).toInt()) - h;
    var l = rnd.nextInt((w * 2).toInt()) - w;
    var animation1 = generateAnimation(0.0, 0.25, 0.0, 1.0);
    var animation2 = generateAnimation(0.3, 0.9, 1.0, 0.0);
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        return Positioned.fill(
          key: Key("item_$top _ $left"),
          top: t * animation2.value,
          left: l * animation2.value,
          child: Transform.scale(
            scale: animation1.value,
            child: Transform.rotate(
              angle: angle * animation2.value,
              child: LogoClipper(top: top, left: left),
            ),
          ),
        );
      },
    );
  }
}

class LogoClipper extends StatelessWidget {
  final double top;
  final double left;
  const LogoClipper({super.key, this.top = 0, this.left = 0});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRect(
        clipper: MyClipper(top: top, left: left),
        child: AppLogo(
          constraints: const BoxConstraints(maxWidth: 250),
          addHero: top == 0 && left == 0,
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Rect> {
  final double top;
  final double left;

  MyClipper({this.top = 0, this.left = 0});
  @override
  Rect getClip(Size size) {
    var w = size.width;
    var h = size.height;
    var t = top * h;
    var l = left * w;
    return Rect.fromLTWH(t, l, w * 0.1, h * 0.1);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return false;
  }
}
