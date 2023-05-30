import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ready_extensions/ready_extensions.dart';
import 'package:ready_form/ready_form.dart';
import 'package:ready_image/config.dart';
import 'package:ready_image/ready_image.dart';
import 'package:ready_validation/ready_validation.dart';
import 'package:tools_sharing/src/main_screen/main_tab/details/tool_details.dart';
import 'package:tools_sharing/src/main_screen/my_tools/manage_item/view.dart';
import 'package:tools_sharing/src/main_screen/shopping_cart_screen.dart';

import 'auth/auth_controller.dart';
import 'auth/confirm_email_view.dart';
import 'auth/forgot_password_view.dart';
import 'auth/login_view.dart';
import 'auth/register_view.dart';
import 'auth/reset_password_view.dart';
import 'localization/app_localizations.dart';
import 'auth/edit_profile.dart';
import 'main_screen/main_screen.dart';
import 'main_screen/orders/orders_list.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';
import 'splash/splash_view.dart';

part 'color_schemes.g.dart';

/// The Widget that configures your application.
class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
    required this.settingsController,
    required this.authController,
  });

  final SettingsController settingsController;
  final AuthController authController;

  @override
  State<MyApp> createState() => _MyAppState();

  static SettingsController settings(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!.widget.settingsController;
  static AuthController auth(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!.widget.authController;
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ReadyImageConfig(
      cacheManager: (context) => CustomCacheManager(),
      fit: (context) => BoxFit.contain,
      child: DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
          ColorScheme lightScheme;
          ColorScheme darkScheme;

          if (lightDynamic != null && darkDynamic != null) {
            lightScheme = lightDynamic.harmonized();

            // Repeat for the dark color scheme.
            darkScheme = darkDynamic.harmonized();
          } else {
            // Otherwise, use fallback schemes.
            lightScheme = lightColorScheme;
            darkScheme = darkColorScheme;
          }
          return ReadyFormConfig(
            autoValidateMode: FormAutoValidateMode.onSubmit,
            child: ListenableBuilder(
              listenable: widget.settingsController,
              builder: (BuildContext context, Widget? child) {
                return MaterialApp(
                  restorationScopeId: 'app',
                  localizationsDelegates: const [
                    ReadyValidationMessages.delegate,
                    ...AppLocalizations.localizationsDelegates,
                    ReadyExtensionLocalizations.delegate,
                  ],
                  supportedLocales: AppLocalizations.supportedLocales,
                  locale: widget.settingsController.locale ??
                      AppLocalizations.supportedLocales.first,
                  onGenerateTitle: (BuildContext context) =>
                      AppLocalizations.of(context).appTitle,
                  theme: ThemeData(
                    useMaterial3: true,
                    colorScheme: lightScheme,
                  ).customize(),
                  darkTheme: ThemeData(
                    useMaterial3: true,
                    colorScheme: darkScheme,
                  ).customize(),
                  themeMode: widget.settingsController.themeMode,
                  onGenerateRoute: (RouteSettings routeSettings) {
                    return MaterialPageRoute<void>(
                      settings: routeSettings,
                      builder: (BuildContext context) {
                        switch (routeSettings.name) {
                          case LoginView.routeName:
                            return LoginView(controller: widget.authController);
                          case RegisterView.routeName:
                            return RegisterView(
                                controller: widget.authController);
                          case ResetPasswordView.routeName:
                            return const ResetPasswordView();
                          case ForgotPasswordView.routeName:
                            return ForgotPasswordView(
                                controller: widget.authController);
                          case ConfirmEmailView.routeName:
                            return ConfirmEmailView(
                                controller: widget.authController);
                          case SplashView.routeName:
                            return SplashView(
                                authController: widget.authController);
                          case SettingsView.routeName:
                            return SettingsView(
                                controller: widget.settingsController);

                          case OrdersListScreen.routeName:
                            return const OrdersListScreen();
                          case ManageTool.routeName:
                            return const ManageTool();
                          case ToolDetailsScreen.routeName:
                            return const ToolDetailsScreen();
                          case EditProfileScreen.routeName:
                            return EditProfileScreen(
                              authController: widget.authController,
                            );

                          case MainScreenView.routeName:
                            return const MainScreenView();
                          case ShoppingCartScreen.routeName:
                            return const ShoppingCartScreen();
                          default:
                            return SplashView(
                                authController: widget.authController);
                        }
                      },
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class CustomCacheManager extends CacheManager {
  static const key = 'firebaseCache';

  static final CustomCacheManager _instance = CustomCacheManager._();

  factory CustomCacheManager() {
    return _instance;
  }

  CustomCacheManager._()
      : super(Config(key, fileService: FirebaseHttpFileService()));
}

class FirebaseHttpFileService extends HttpFileService {
  static final Map<String, String> loadedUrls = {};
  @override
  Future<FileServiceResponse> get(String url,
      {Map<String, String>? headers}) async {
    if (url.isEmpty || url.startsWith('http:') || url.startsWith('https:')) {
      return await super.get(url);
    }
    var result = loadedUrls[url] ??
        await FirebaseStorage.instance.ref(url).getDownloadURL();
    loadedUrls[url] = result;
    return await super.get(result);
  }
}
