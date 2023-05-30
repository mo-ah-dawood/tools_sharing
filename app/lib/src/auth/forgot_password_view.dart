import 'package:flutter/material.dart';
import 'package:ready_form/ready_form.dart';
import 'package:ready_validation/ready_validation.dart';

import '../localization/app_localizations.dart';
import '../shared/app_logo.dart';
import '../shared/platform_screen.dart';
import 'auth_controller.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key, required this.controller});

  static const routeName = '/ForgotPassword';

  final AuthController controller;

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  String email = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PlatformScreen(
        child: ReadyForm(
          onPostData: () async {
            await widget.controller.sendForgotPasswordCode(context, email);
            return OnPostDataResult();
          },
          child: Center(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(30),
              children: [
                const Center(child: AppLogo.horizontal()),
                const SizedBox(height: 50),
                TextFormField(
                  onSaved: (newValue) {
                    email = newValue ?? "";
                  },
                  maxLength: 255,
                  keyboardType: TextInputType.emailAddress,
                  validator: context.string().required().email(),
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).email),
                ),
                const SizedBox(height: 50),
                ProgressButton(child: Text(AppLocalizations.of(context).next)),
                const SizedBox(height: 30),
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
                          AppLocalizations.of(context).login.toLowerCase(),
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
      ),
    );
  }
}
