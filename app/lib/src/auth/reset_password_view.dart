import 'package:flutter/material.dart';

import '../localization/app_localizations.dart';
import '../shared/app_logo.dart';
import '../shared/platform_screen.dart';
import 'login_view.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  static const routeName = '/ResetPassword';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PlatformScreen(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(30),
            children: [
              const Center(child: AppLogo.horizontal()),
              const SizedBox(height: 50),
              Text(
                AppLocalizations.of(context).resetLinkSentToYourEmail,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).popUntil(
                      (route) => route.settings.name == LoginView.routeName);
                },
                child: Text(AppLocalizations.of(context).login),
              ),
              const SizedBox(height: 50),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text.rich(
                  TextSpan(children: [
                    TextSpan(
                      text: AppLocalizations.of(context).backTo,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const TextSpan(text: " "),
                    WidgetSpan(
                      child: Text(
                        AppLocalizations.of(context).changeEmail.toLowerCase(),
                      ),
                    )
                  ]),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
