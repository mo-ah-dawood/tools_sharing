import 'package:flutter/material.dart';
import 'package:tools_sharing/src/auth/user.dart';

import '../../app.dart';
import '../../shared/loading_sliver.dart';
import '../../shared/no_items_found.dart';
import '../main_screen.dart';
import '../tools/service.dart';
import '../tools/tool_view.dart';
import 'controller.dart';
import 'manage_item/view.dart';

class MyToolsTab extends StatefulWidget {
  const MyToolsTab({super.key});

  @override
  State<MyToolsTab> createState() => _MyToolsTabState();
}

class _MyToolsTabState extends State<MyToolsTab> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: MyApp.auth(context),
      builder: (BuildContext context, Widget? child) {
        var user = MyApp.auth(context).user;
        if (user == null) {
          return const SizedBox();
        }
        return _InnerList(user: user);
      },
    );
  }
}

class _InnerList extends StatefulWidget {
  final UserModel user;
  const _InnerList({required this.user});

  @override
  State<_InnerList> createState() => _InnerListState();
}

class _InnerListState extends State<_InnerList> {
  late final MyToolsController controller;
  @override
  void initState() {
    controller = MyToolsController(ToolsService());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    controller.listen(widget.user);
    controller.addListener(_onChanged);
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant _InnerList oldWidget) {
    if (widget.user != oldWidget.user) {
      controller.listen(widget.user);
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
        var list =
            controller.list.where((e) => e.name.contains(ctrl.text)).toList();
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
                sliver: SliverList.builder(
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    var item = list[index];
                    return ToolView(
                      onPressed: controller.lastUpdate == null
                          ? null
                          : () {
                              Navigator.of(context).pushNamed(
                                  ManageTool.routeName,
                                  arguments: item);
                            },
                      item: item,
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
