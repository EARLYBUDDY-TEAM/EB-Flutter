part of '../eb_uikit.dart';

WidgetBuilder builderModalBottomSheet({
  required BuildContext context,
  required MaterialPageRoute onGenerateRoute,
}) {
  return (context) => Material(
        child: Navigator(
          onGenerateRoute: (context) => onGenerateRoute,
        ),
      );
}
