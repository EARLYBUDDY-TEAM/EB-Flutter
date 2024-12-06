part of '../eb_uikit.dart';

final class EBTheme {
  final highlightColor = EBColors.blue3.withOpacity(0.05);
  final splashColor = EBColors.blue3.withOpacity(0.1);

  ThemeData light() {
    const mode = ThemeMode.light;
    return _ebTheme(mode);
  }

  ThemeData dark() {
    const mode = ThemeMode.dark;
    return _ebTheme(mode);
  }

  ThemeData _ebTheme(ThemeMode mode) {
    return ThemeData(
      highlightColor: highlightColor,
      splashColor: splashColor,
      textButtonTheme: _textButtonTheme,
      timePickerTheme: _timePickerTheme,
      colorScheme: _colorScheme(mode),
      buttonTheme: _buttonTheme(mode),
    );
  }

  ButtonThemeData _buttonTheme(ThemeMode mode) {
    return ButtonThemeData(
      highlightColor: highlightColor,
      splashColor: splashColor,
    );
  }

  TextButtonThemeData get _textButtonTheme {
    return TextButtonThemeData(
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.resolveWith((states) {
          return splashColor;
        }),
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

  TimePickerThemeData get _timePickerTheme {
    return TimePickerThemeData(
      hourMinuteColor: EBColors.purple1.withOpacity(0.4),
      dayPeriodColor: Colors.pink.shade100.withOpacity(0.5),
      dialHandColor: EBColors.purple1,
    );
  }

  ColorScheme _colorScheme(ThemeMode mode) {
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
