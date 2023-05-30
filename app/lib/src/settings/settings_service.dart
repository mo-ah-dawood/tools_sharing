import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  Future<Locale?> locale() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var val = pref.getString('locale');
    if (val == null || val.isEmpty) {
      return null;
    }
    return Locale(val);
  }

  Future<void> updateLocale(Locale? locale) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (locale == null) {
      pref.remove('locale');
    } else {
      pref.setString('locale', locale.languageCode);
    }
  }

  Future<ThemeMode> themeMode() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var theme = pref.getString('theme');
    if (theme == null || theme.isEmpty) {
      return ThemeMode.system;
    }
    return ThemeMode.values.byName(theme);
  }

  Future<void> updateThemeMode(ThemeMode theme) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('theme', theme.name);
  }
}
