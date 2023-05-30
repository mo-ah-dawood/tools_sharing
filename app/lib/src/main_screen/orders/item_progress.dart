import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'order_item.dart';

class ItemProgress extends StatelessWidget {
  final OrderItem item;
  final Timestamp startDate;
  final double size;
  const ItemProgress(
      {super.key, required this.item, required this.startDate, this.size = 30});

  @override
  Widget build(BuildContext context) {
    var totalDuration = Duration(days: item.days).inMilliseconds;
    var sdate = startDate.toDate();
    var passed = totalDuration -
        sdate
            .add(Duration(days: item.days))
            .difference(DateTime.now())
            .inMilliseconds;
    var progress = (passed / totalDuration).clamp(0.0, 1.0);
    var color = switch (progress) {
      < 0.5 => Colors.green,
      >= 0.5 && < 0.7 => Colors.blue,
      >= 0.7 && < 0.8 => Colors.amber,
      _ => Colors.red,
    };
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        value: progress,
        color: color,
        backgroundColor: color.withOpacity(0.1),
      ),
    );
  }
}
