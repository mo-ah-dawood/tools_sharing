import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tools_sharing/src/shared/extensions.dart';

import '../../app.dart';
import '../../shared/loading_sliver.dart';
import '../../shared/no_items_found.dart';
import '../categories/category.dart';
import '../categories/controller.dart';
import '../main_screen.dart';
import '../tools/service.dart';
import '../tools/tool_view.dart';
import 'controller.dart';
import 'details/tool_details.dart';

class ToolsTab extends StatelessWidget {
  final CategoriesController controller;
  const ToolsTab({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (BuildContext context, Widget? child) {
        return TabBarView(
          controller: controller.controller,
          children: _list(context),
        );
      },
    );
  }

  List<Widget> _list(BuildContext context) {
    if (controller.lastupdated == null) {
      return List.generate(controller.controller.length,
          (index) => const _InnerList(category: null));
    } else if (controller.list.isEmpty) {
      return [_InnerList(category: Category(id: '', name: ''))];
    } else {
      return [
        _InnerList(category: Category(id: '', name: '')),
        ...controller.list.map((e) => _InnerList(
              category: e,
            ))
      ];
    }
  }
}

class _InnerList extends StatefulWidget {
  final Category? category;
  const _InnerList({required this.category});

  @override
  State<_InnerList> createState() => _InnerListState();
}

class _InnerListState extends State<_InnerList> {
  late final ToolsController controller;
  @override
  void initState() {
    controller = ToolsController(ToolsService());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    controller.listen(widget.category, MyApp.auth(context).user);
    controller.addListener(_onChanged);
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant _InnerList oldWidget) {
    if (widget.category != oldWidget.category) {
      controller.listen(widget.category, MyApp.auth(context).user);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var ctrl = MainScreenView.controller(context);
    return ListenableBuilder(
      listenable: ctrl,
      builder: (BuildContext context, Widget? child) {
        var list = controller.list
            .where(
                (e) => e.name.toLowerCase().contains(ctrl.text.toLowerCase()))
            .toList();
        return CustomScrollView(
          slivers: [
            SliverOverlapInjector(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
            if (controller.lastUpdate == null)
              const LoadingSliver()
            else if (list.isEmpty && controller.lastUpdate != null)
              const NoItemsFound()
            else
              SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverMasonryGrid.count(
                  crossAxisCount: context.responCrossAxisCount(),
                  childCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    var item = list[index];
                    return ToolView(
                      item: item,
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          ToolDetailsScreen.routeName,
                          arguments: {
                            "item": item,
                            "ctrl": MainScreenView.cart(context)
                          },
                        );
                      },
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }

  void _onChanged() {
    setState(() {});
  }
}
