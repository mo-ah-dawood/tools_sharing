import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'src/app.dart';
import 'src/auth/auth_controller.dart';
import 'src/auth/auth_service.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final settingsController = SettingsController(SettingsService());
  final authController = AuthController(AuthService());
  await settingsController.loadSettings();
  authController.loadUser();
  WidgetsBinding.instance.addObserver(authController);

  runApp(MyApp(
    settingsController: settingsController,
    authController: authController,
  ));
}
