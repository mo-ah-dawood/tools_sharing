import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_fatoorah/my_fatoorah.dart';
import 'package:ready_extensions/ready_extensions.dart';
import 'package:ready_form/ready_form.dart';
import 'package:ready_validation/ready_validation.dart';

import '../../app.dart';
import '../../localization/app_localizations.dart';
import '../../shared/app_logo.dart';
import '../main_screen.dart';
import 'wallet_controller.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: MyApp.settings(context),
      builder: (BuildContext context, Widget? child) {
        return CustomScrollView(
          slivers: [
            SliverOverlapInjector(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
            const SliverToBoxAdapter(child: SizedBox(height: 50)),
            const SliverToBoxAdapter(
                child: Center(child: AppLogo.horizontal())),
            SliverToBoxAdapter(
              child: ListenableBuilder(
                listenable: MainScreenView.wallet(context),
                builder: (BuildContext context, Widget? child) {
                  var ctrl = MainScreenView.wallet(context);
                  return _itemsBuilder([
                    ListTile(
                      trailing: TextButton(
                        onPressed: () async {
                          var current = ctrl.wallet;
                          await showDialog(
                            context: context,
                            builder: (ctx) {
                              return _ChargeDialog(ctrl);
                            },
                          );
                          var charged = ctrl.wallet - current;
                          if (charged > 0 && context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(AppLocalizations.of(context)
                                    .yourWalletSuccessFullyChargedWith(
                                        charged.noTrailing()))));
                          }
                        },
                        child: Text(AppLocalizations.of(context).charge),
                      ),
                      isThreeLine: true,
                      subtitle: Text(AppLocalizations.of(context).balance),
                      title: Text(
                        "${MainScreenView.wallet(context).wallet.noTrailing()} ${AppLocalizations.of(context).currencyDisplay}",
                        style:
                            Theme.of(context).extension<AppStyles>()?.pricLarge,
                      ),
                    ),
                  ]);
                },
              ),
            ),
            SliverToBoxAdapter(
              child: _itemsBuilder([
                ListTile(
                  title: Text(AppLocalizations.of(context).language),
                ),
                for (var locale in AppLocalizations.supportedLocales)
                  RadioListTile(
                    title: _localeDisplay(context, locale),
                    groupValue: MyApp.settings(context).locale,
                    onChanged: (Locale? value) {
                      MyApp.settings(context).updateLocale(locale);
                    },
                    value: locale,
                  ),
              ]),
            ),
            SliverToBoxAdapter(
              child: _itemsBuilder([
                ListTile(
                  title: Text(AppLocalizations.of(context).theme),
                ),
                _themeModeItem(context, ThemeMode.system),
                _themeModeItem(context, ThemeMode.light),
                _themeModeItem(context, ThemeMode.dark),
              ]),
            ),
            SliverToBoxAdapter(
              child: _itemsBuilder([
                ListTile(
                  title: Text(AppLocalizations.of(context).logout),
                  onTap: () async {
                    await MyApp.auth(context).signOut(context);
                  },
                )
              ]),
            ),
          ],
        );
      },
    );
  }

  RadioListTile<ThemeMode> _themeModeItem(
      BuildContext context, ThemeMode mode) {
    late String display;
    switch (mode) {
      case ThemeMode.dark:
        display = AppLocalizations.of(context).dark;
        break;
      case ThemeMode.light:
        display = AppLocalizations.of(context).light;
        break;
      case ThemeMode.system:
        display = AppLocalizations.of(context).system;
        break;
    }
    return RadioListTile(
      title: Text(display),
      groupValue: MyApp.settings(context).themeMode,
      onChanged: (ThemeMode? value) {
        MyApp.settings(context).updateThemeMode(mode);
      },
      value: mode,
    );
  }

  Card _itemsBuilder(List<Widget> children) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }

  Localizations _localeDisplay(BuildContext context, Locale locale) {
    return Localizations.override(
      context: context,
      locale: locale,
      child: Builder(builder: (ctx) {
        return Text(
          AppLocalizations.of(ctx).languageDisplay,
          textDirection: Directionality.of(context),
        );
      }),
    );
  }
}

class _ChargeDialog extends StatefulWidget {
  final Walletontroller controller;
  const _ChargeDialog(this.controller);

  @override
  State<_ChargeDialog> createState() => _ChargeDialogState();
}

class _ChargeDialogState extends State<_ChargeDialog> {
  double? value = 0;
  PaymentMethod? selectedmethod;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: MyFatoorah(
        onResult: (res) async {
          if (res.isSuccess && context.mounted) {
            await widget.controller.charge(context, value!);
            if (context.mounted) {
              Navigator.of(context).popUntil(
                (r) => r.settings.name == MainScreenView.routeName,
              );
            }
          }
        },
        builder: (methods, state, submit) {
          return ReadyForm(
            onPostData: () async {
              try {
                if (selectedmethod == null) OnPostDataResult();
                await submit(selectedmethod!);
              } catch (e) {
                if (kDebugMode) {
                  print(e);
                }
              }
              return OnPostDataResult();
            },
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(20),
              children: [
                ListTile(
                  title: Text(AppLocalizations.of(context).charge),
                  contentPadding: EdgeInsets.zero,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: AppLocalizations.of(context).value),
                  validator:
                      context.string().required().isDecimal().greaterThan(10),
                  onChanged: (v) {
                    setState(() {
                      value = double.tryParse(v);
                    });
                  },
                ),
                const SizedBox(height: 20),
                ...methods.map((e) => RadioListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(e.paymentMethod),
                      onChanged: (PaymentMethod? value) {
                        setState(() {
                          selectedmethod = value;
                        });
                      },
                      value: e,
                      groupValue: selectedmethod,
                    )),
                ProgressButton(child: Text(AppLocalizations.of(context).next))
              ],
            ),
          );
        },
        successChild: Center(
          child: Image.asset('assets/images/success.png'),
        ),
        errorChild: Center(
          child: Image.asset('assets/images/fail.png'),
        ),
        request: MyfatoorahRequest.test(
          token:
              'rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL',
          language: Localizations.localeOf(context).languageCode == 'ar'
              ? ApiLanguage.Arabic
              : ApiLanguage.English,
          invoiceAmount: value!,
          successUrl: 'https://tsvsghss.com',
          errorUrl: 'https://sdjhgsdhsdg.com',
          currencyIso: Country.Egypt,
        ),
      ),
    );
  }
}
