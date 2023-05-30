import 'package:flutter/material.dart';
import 'package:ready_form/ready_form.dart';
import 'package:ready_validation/ready_validation.dart';

import '../localization/app_localizations.dart';
import '../shared/app_logo.dart';
import '../shared/platform_screen.dart';
import 'auth_controller.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key, required this.controller});

  static const routeName = '/Register';

  final AuthController controller;

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  String email = "";
  String password = "";
  String name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PlatformScreen(
        child: ReadyForm(
          onPostData: () async {
            await widget.controller.register(context, email, password, name);
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
                  textInputAction: TextInputAction.next,
                  autofillHints: const [
                    AutofillHints.username,
                    AutofillHints.email,
                  ],
                  keyboardType: TextInputType.emailAddress,
                  maxLength: 255,
                  validator: context.string().required().email(),
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).email),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  onSaved: (newValue) {
                    name = newValue ?? "";
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  autofillHints: const [AutofillHints.name],
                  validator: context.string().required().hasMinLength(10),
                  maxLength: 100,
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).name),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  onSaved: (newValue) {
                    password = newValue ?? "";
                  },
                  obscureText: true,
                  autofillHints: const [AutofillHints.password],
                  maxLength: 30,
                  textInputAction: TextInputAction.done,
                  validator: context.string().required().hasMinLength(6),
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).password),
                ),
                const SizedBox(height: 50),
                FormField<bool>(
                    validator: context.boolean().equal(true),
                    builder: (field) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(AppLocalizations.of(context)
                            .termsAndConditionsApproval),
                        onTap: () {
                          showAboutDialog(context: context);
                        },
                        leading: Checkbox(
                          onChanged: (bool? value) {
                            field.didChange(value);
                          },
                          value: field.value == true,
                        ),
                      );
                    }),
                ProgressButton(
                  child: Text(AppLocalizations.of(context).register),
                ),
                const SizedBox(height: 30),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: AppLocalizations.of(context).alreadyHaveAnAccount,
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
