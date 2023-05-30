import 'dart:async';

import 'package:flutter/material.dart';

import '../../../app.dart';
import '../../../auth/edit_profile.dart';
import '../../../localization/app_localizations.dart';
import '../../tools/tool_item.dart';
import 'service.dart';

class ManageToolController with ChangeNotifier {
  final ManageToolService _service;
  ManageToolController(this._service);
  Future<T> _handle<T>(BuildContext? context, Future<T> action) async {
    try {
      return await action;
    } catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
      rethrow;
    }
  }

  Future _showCompleteSnackBar(BuildContext context) async {
    var res = await ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(
          content:
              Text(AppLocalizations.of(context).youShouldCompleteYourProfile),
          action: SnackBarAction(
            label: AppLocalizations.of(context).sure,
            onPressed: () {},
          ),
        ))
        .closed;
    if (res == SnackBarClosedReason.action && context.mounted) {
      await Navigator.of(context).pushNamed(EditProfileScreen.routeName);
    }
  }

  Future<bool> _checkProfile(BuildContext context) async {
    var auth = MyApp.auth(context);
    var user = auth.user!;
    if (user.phone.isEmpty) {
      await _showCompleteSnackBar(context);
    }
    if (user.address == null && context.mounted) {
      await _showCompleteSnackBar(context);
    }
    return user.phone.isNotEmpty && user.address != null;
  }

  Future add(BuildContext context, Tool tool) async {
    var canProceed = await _checkProfile(context);
    if (canProceed && context.mounted) {
      await _handle(context, _service.add(tool));
      if (context.mounted) Navigator.of(context).pop();
    }
  }

  Future update(BuildContext context, Tool tool) async {
    await _handle(context, _service.update(tool));
    if (context.mounted) Navigator.of(context).pop();
  }

  Future delete(BuildContext context, Tool tool) async {
    await _handle(context, _service.delete(tool));
    if (context.mounted) Navigator.of(context).pop();
  }
}
