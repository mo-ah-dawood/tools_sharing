import 'package:flutter/material.dart';
import 'package:ready_form/ready_form.dart';
import 'package:ready_validation/ready_validation.dart';
import 'package:tools_sharing/src/shared/google_button.dart';

import '../localization/app_localizations.dart';
import '../shared/app_logo.dart';
import '../shared/platform_screen.dart';
import 'auth_controller.dart';
import 'forgot_password_view.dart';
import 'register_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key, required this.controller});

  static const routeName = '/Login';

  final AuthController controller;

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PlatformScreen(
        child: ReadyForm(
          onPostData: () async {
            await widget.controller.login(context, email, password);
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
                    password = newValue ?? "";
                  },
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  autofillHints: const [AutofillHints.password],
                  maxLength: 30,
                  validator: context.string().required().hasMinLength(6),
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).password),
                ),
                const SizedBox(height: 50),
                Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(ForgotPasswordView.routeName);
                    },
                    child: Text(AppLocalizations.of(context).forgotPassword),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    if (widget.controller.googleEnabled) ...[
                      Expanded(
                        child: GoogleButton(
                          label: AppLocalizations.of(context).loginWithGoogle,
                          onPressed: () =>
                              widget.controller.loginWithGoogle(context),
                        ),
                      ),
                      Expanded(
                        child: Text(AppLocalizations.of(context).or,
                            textAlign: TextAlign.center),
                      ),
                    ],
                    Expanded(
                      child: ProgressButton(
                        child: FittedBox(
                          child: Text(AppLocalizations.of(context).login),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(RegisterView.routeName);
                  },
                  child: Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: AppLocalizations.of(context).dontHaveAccount,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const TextSpan(text: "  "),
                      WidgetSpan(
                        child: Text(
                          AppLocalizations.of(context).register.toLowerCase(),
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
