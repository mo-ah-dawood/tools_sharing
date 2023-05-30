import 'package:flutter/material.dart';
import 'package:ready_extensions/ready_extensions.dart';
import 'package:ready_image/ready_image.dart';

import '../../../app.dart';
import '../../../auth/auth_service.dart';
import '../../../auth/user.dart';
import '../../../localization/app_localizations.dart';
import '../../../shared/remote_builder.dart';
import '../../categories/category.dart';
import '../../categories/service.dart';
import '../../tools/service.dart';
import '../../tools/tool_item.dart';
import '../../tools/tool_view.dart';
import 'controller.dart';

part 'app_bar.dart';
part 'counter.dart';
part 'details.dart';

class ToolDetailsScreen extends StatefulWidget {
  static const routeName = '/ToolDetails';
  const ToolDetailsScreen({super.key});

  @override
  State<ToolDetailsScreen> createState() => _ToolDetailsScreenState();
}

class _ToolDetailsScreenState extends State<ToolDetailsScreen> {
  late final ToolDetailsController controller;
  @override
  void didChangeDependencies() {
    Map args = ModalRoute.of(context)!.settings.arguments as Map;
    controller = ToolDetailsController(
        ToolsService(), args['item'], args['ctrl'], _onRentChanged);
    controller.addListener(_onChanged);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Tool tool = controller.model;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _AppBar(tool: tool),
          _Details(tool: tool),
          _Counter(controller: controller),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverToBoxAdapter(
              child: ListenableBuilder(
                listenable: controller,
                builder: (context, _) {
                  if (tool.isRented) return const SizedBox();
                  return Text(
                    AppLocalizations.of(context).toolHint,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).extension<AppStyles>()?.hint,
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onChanged() {
    setState(() {});
  }

  void _onRentChanged() {
    var isRented = controller.model.isRented;
    if (isRented) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context).toolRentedFromOthers)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context).toolBecomeAvailble)));
    }
  }
}
