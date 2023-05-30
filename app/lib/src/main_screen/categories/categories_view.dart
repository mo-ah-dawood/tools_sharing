import 'package:flutter/material.dart';
import 'package:tools_sharing/src/localization/app_localizations.dart';
import 'package:tools_sharing/src/main_screen/categories/controller.dart';

class CategoriesView extends StatefulWidget implements PreferredSizeWidget {
  final CategoriesController controller;
  final bool show;
  const CategoriesView(
      {super.key, required this.controller, required this.show});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();

  @override
  Size get preferredSize => Size.fromHeight(show ? kToolbarHeight : 0);
}

class _CategoriesViewState extends State<CategoriesView> {
  @override
  void initState() {
    widget.controller.listen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      child: _build(context),
    );
  }

  Widget _build(BuildContext context) {
    if (!widget.show) return const SizedBox();
    return ListenableBuilder(
        listenable: widget.controller,
        builder: (context, _) {
          return SizedBox(
            key: Key(widget.controller.lastupdated.toString()),
            height: widget.preferredSize.height,
            width: double.maxFinite,
            child: TabBar(
              isScrollable: true,
              controller: widget.controller.controller,
              tabs: _list(context),
            ),
          );
        });
  }

  List<Widget> _list(BuildContext context) {
    if (widget.controller.lastupdated == null) {
      return _loading();
    } else if (widget.controller.list.isEmpty) {
      return _empty(context);
    } else {
      return [
        Tab(text: AppLocalizations.of(context).all),
        ...widget.controller.list.map((e) => Tab(text: e.name)),
      ];
    }
  }

  List<Widget> _empty(BuildContext context) =>
      [Tab(text: AppLocalizations.of(context).all)];

  List<Widget> _loading() {
    return List.generate(
      widget.controller.controller.length,
      (index) => const Opacity(
        opacity: 0.1,
        child: SizedBox(
          width: 100,
          height: 10,
          child: LinearProgressIndicator(),
        ),
      ),
    );
  }
}
