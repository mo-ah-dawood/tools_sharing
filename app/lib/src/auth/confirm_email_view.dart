import 'package:flutter/material.dart';
import 'package:ready_form/ready_form.dart';

import '../localization/app_localizations.dart';
import '../main_screen/main_screen.dart';
import '../shared/app_logo.dart';
import '../shared/platform_screen.dart';
import 'auth_controller.dart';
import 'login_view.dart';

class ConfirmEmailView extends StatefulWidget {
  const ConfirmEmailView({super.key, required this.controller});

  static const routeName = '/ConfirmEmail';

  final AuthController controller;

  @override
  State<ConfirmEmailView> createState() => _ConfirmEmailViewState();
}

class _ConfirmEmailViewState extends State<ConfirmEmailView> {
  @override
  void initState() {
    widget.controller.addListener(_onChanged);
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, child) {
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
                    AppLocalizations.of(context)
                        .confirmationLinkSendToYourEmail,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),
                  Row(
                    children: [
                      Expanded(
                        child: ProgressButton(
                          onPressed: widget.controller.refresh,
                          child: Text(AppLocalizations.of(context).check),
                        ),
                      ),
                      Expanded(
                        child: Center(
                            child: Text(AppLocalizations.of(context).or)),
                      ),
                      Expanded(
                        child: ProgressButton(
                          type: ButtonType.outlined,
                          onPressed: () => widget.controller.signOut(context),
                          child: Text(AppLocalizations.of(context).logout),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  ProgressButton(
                    type: ButtonType.text,
                    onPressed: () async {
                      await widget.controller.sendVerificationCode(context);
                    },
                    child: Text.rich(
                      TextSpan(children: [
                        TextSpan(
                          text: AppLocalizations.of(context).dontGetEmail,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const TextSpan(text: " "),
                        WidgetSpan(
                          child: Text(
                            AppLocalizations.of(context)
                                .sendAgain
                                .toLowerCase(),
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
      },
    );
  }

  void _onChanged() {
    if (widget.controller.emailVerified && mounted) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(MainScreenView.routeName, (route) => false);
    } else if (!widget.controller.authenticated && mounted) {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      } else {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(LoginView.routeName, (route) => false);
      }
    }
  }
}
