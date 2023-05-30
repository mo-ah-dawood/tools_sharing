import 'dart:math';

import 'package:flutter/material.dart';

import '../localization/app_localizations.dart';

extension BuildContextExt on BuildContext {
  int responCrossAxisCount([double itemMax = 300]) {
    var width = MediaQuery.of(this).size.width;
    return width ~/ 300;
  }

  Future showLoading<T>(Future Function() action) {
    return showDialog<T>(
      context: this,
      barrierDismissible: false,
      builder: (context) => _Loading(action),
    );
  }
}

class _Loading extends StatefulWidget {
  final Future Function() action;

  const _Loading(this.action);

  @override
  State<_Loading> createState() => _LoadingState();
}

class _LoadingState extends State<_Loading> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> _curved;
  late List<String> chars = [];
  late List<Animation<double>> animations = [];

  void _action() {
    widget.action().then((value) {
      Navigator.of(context).pop(value);
    }).catchError((e) {
      Navigator.of(context).pop();
    });
  }

  @override
  void didChangeDependencies() {
    if (Localizations.localeOf(context).languageCode == 'ar') {
      controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 2000),
        reverseDuration: const Duration(milliseconds: 300),
      );
    } else {
      controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 3000),
        reverseDuration: const Duration(milliseconds: 300),
      );
    }

    _curved = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOutExpo),
    );
    controller.repeat(reverse: true);
    chars = AppLocalizations.of(context).loadingPleaseWait.split('');
    for (int i = 0; i < chars.length; i++) {
      var itemduration = 1 / chars.length;
      var start = (i * itemduration - itemduration * 0.25).clamp(0.0, 1.0);
      var end = (i + 1) * itemduration;
      animations.add(Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _curved,
        curve: Interval(start, end),
      )));
    }
    _action();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Localizations.localeOf(context).languageCode == 'ar'
            ? _arabic()
            : _nonArabic(),
      ),
    );
  }

  Text _nonArabic() {
    return Text.rich(
      TextSpan(
        children: [for (var i = 0; i < chars.length; i++) _span(i)],
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _arabic() {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        var count = (chars.length * _curved.value).toInt();
        return Text(
          chars.take(count + 1).join(),
          textAlign: TextAlign.center,
        );
      },
    );
  }

  WidgetSpan _span(int i) {
    return WidgetSpan(
      child: AnimatedBuilder(
        animation: animations[i],
        builder: (context, _) {
          return Opacity(
            opacity: animations[i].value,
            child: Transform.rotate(
              angle: -pi / 4 * (1 - animations[i].value),
              child: Text(chars[i]),
            ),
          );
        },
      ),
    );
  }
}
