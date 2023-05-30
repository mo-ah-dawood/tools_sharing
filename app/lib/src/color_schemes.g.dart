part of 'app.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF0061A2),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFD1E4FF),
  onPrimaryContainer: Color(0xFF001D35),
  secondary: Color(0xFF535F70),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFD6E4F7),
  onSecondaryContainer: Color(0xFF0F1C2B),
  tertiary: Color(0xFF805600),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFFFDDAF),
  onTertiaryContainer: Color(0xFF281800),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFFDFCFF),
  onBackground: Color(0xFF1A1C1E),
  surface: Color(0xFFFDFCFF),
  onSurface: Color(0xFF1A1C1E),
  surfaceVariant: Color(0xFFDFE2EB),
  onSurfaceVariant: Color(0xFF42474E),
  outline: Color(0xFF73777F),
  onInverseSurface: Color(0xFFF1F0F4),
  inverseSurface: Color(0xFF2F3033),
  inversePrimary: Color(0xFF9DCAFF),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF0061A2),
  outlineVariant: Color(0xFFC3C7CF),
  scrim: Color(0xFF000000),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF9DCAFF),
  onPrimary: Color(0xFF003257),
  primaryContainer: Color(0xFF00497C),
  onPrimaryContainer: Color(0xFFD1E4FF),
  secondary: Color(0xFFBAC8DB),
  onSecondary: Color(0xFF253140),
  secondaryContainer: Color(0xFF3B4858),
  onSecondaryContainer: Color(0xFFD6E4F7),
  tertiary: Color(0xFFFFBA43),
  onTertiary: Color(0xFF442C00),
  tertiaryContainer: Color(0xFF614000),
  onTertiaryContainer: Color(0xFFFFDDAF),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF1A1C1E),
  onBackground: Color(0xFFE2E2E6),
  surface: Color(0xFF1A1C1E),
  onSurface: Color(0xFFE2E2E6),
  surfaceVariant: Color(0xFF42474E),
  onSurfaceVariant: Color(0xFFC3C7CF),
  outline: Color(0xFF8D9199),
  onInverseSurface: Color(0xFF1A1C1E),
  inverseSurface: Color(0xFFE2E2E6),
  inversePrimary: Color(0xFF0061A2),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF9DCAFF),
  outlineVariant: Color(0xFF42474E),
  scrim: Color(0xFF000000),
);

extension ThemeExt on ThemeData {
  ThemeData customize() {
    return copyWith(
      extensions: [AppStyles(this)],
      textTheme: textTheme.copyWith(
        bodySmall: TextStyle(
          color: colorScheme.onSurface.withOpacity(0.3),
        ),
      ),
    );
  }
}

class AppStyles extends ThemeExtension<AppStyles> {
  final ThemeData _defaultTheme;
  TextStyle get price => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: _defaultTheme.colorScheme.primary,
      );

  TextStyle get pricLarge => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: _defaultTheme.colorScheme.primary,
      );

  TextStyle get pricVeryLarge => TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: _defaultTheme.colorScheme.primary,
      );

  TextStyle get hint => TextStyle(
        fontSize: 13,
        color: _defaultTheme.colorScheme.error,
      );

  AppStyles(this._defaultTheme);
  @override
  ThemeExtension<AppStyles> copyWith() {
    return AppStyles(_defaultTheme);
  }

  @override
  ThemeExtension<AppStyles> lerp(
      covariant ThemeExtension<AppStyles>? other, double t) {
    return AppStyles(_defaultTheme);
  }
}
