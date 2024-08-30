part of '../eb_uikit.dart';

final class EBTheme {
  static ThemeData light() {
    const mode = ThemeMode.light;
    return _ebTheme(mode);
  }

  static ThemeData dark() {
    const mode = ThemeMode.dark;
    return _ebTheme(mode);
  }

  static ThemeData _ebTheme(ThemeMode mode) {
    return ThemeData(
      textButtonTheme: _textButtonTheme,
      timePickerTheme: _timePickerTheme,
      colorScheme: _colorScheme(mode),
    );
  }

  static TextButtonThemeData get _textButtonTheme {
    return TextButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStateProperty.resolveWith((states) {
          return const TextStyle(
            fontFamily: FontFamily.nanumSquareExtraBold,
          );
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          return EBColors.purple2;
        }),
      ),
    );
  }

  static TimePickerThemeData get _timePickerTheme {
    return TimePickerThemeData(
      hourMinuteColor: EBColors.purple1.withOpacity(0.4),
      dayPeriodColor: Colors.pink.shade100.withOpacity(0.5),
      dialHandColor: EBColors.purple1,
    );
  }

  static ColorScheme _colorScheme(ThemeMode mode) {
    switch (mode) {
      case (ThemeMode.light):
        return ColorScheme.light(
          primary: EBColors.purple1,
          onPrimary: EBColors.text,
          onSurface: EBColors.text,
        );
      default:
        return ColorScheme.dark(
          primary: EBColors.purple1,
          onPrimary: EBColors.text,
          onSurface: EBColors.text,
        );
    }
  }
}
