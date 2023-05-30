import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RemoteBuilder<T> extends StatefulWidget {
  final String collection;
  final String id;
  final T Function(Map<String, dynamic> data) mapper;
  final Widget Function(T data) builder;
  const RemoteBuilder({
    super.key,
    required this.collection,
    required this.id,
    required this.builder,
    required this.mapper,
  });

  @override
  State<RemoteBuilder<T>> createState() => _RemoteBuilderState<T>();
}

class _RemoteBuilderState<T> extends State<RemoteBuilder<T>> {
  StreamSubscription? listner;
  Map<String, dynamic> data = {};
  @override
  void initState() {
    data['id'] = widget.id;
    _listen();
    super.initState();
  }

  void _listen() {
    listner?.cancel();
    listner = FirebaseFirestore.instance
        .collection(widget.collection)
        .doc(widget.id)
        .snapshots()
        .listen(_onDataChanged);
  }

  @override
  void didUpdateWidget(covariant RemoteBuilder<T> oldWidget) {
    if (widget.collection != oldWidget.collection ||
        widget.id != oldWidget.id) {
      _listen();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    listner?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(widget.mapper(data));
  }

  void _onDataChanged(DocumentSnapshot<Map<String, dynamic>> event) {
    setState(() {
      data = event.data() ?? {};
      data['id'] = event.id;
    });
  }
}
