import 'package:flutter/material.dart';
import 'package:tools_sharing/src/app.dart';
import 'package:tools_sharing/src/localization/app_localizations.dart';

class UserName extends StatelessWidget {
  const UserName({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: MyApp.auth(context),
      builder: (BuildContext context, Widget? child) {
        var user = MyApp.auth(context).user!;
        return Text(AppLocalizations.of(context).welcome(user.name));
      },
    );
  }
}
