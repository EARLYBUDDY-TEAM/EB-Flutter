part of '../eb_root.dart';

final class ComposeView extends StatefulWidget {
  const ComposeView({super.key});

  @override
  State<StatefulWidget> createState() => _ComposeState();
}

final class _ComposeState extends State<ComposeView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
      supportedLocales: const [
        Locale('en'),
        Locale('ko'),
      ],
      theme: EBTheme.light(),
      navigatorKey: _navigatorKey,
    );
  }
  // const ComposeView({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   final _navigatorKey = GlobalKey<NavigatorState>();

  // NavigatorState get _navigator => _navigatorKey.currentState!;

  //   return MaterialApp(
  //     localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
  //     supportedLocales: const [
  //       Locale('en'),
  //       Locale('ko'),
  //     ],
  //     theme: EBTheme.light(),
  //     navigatorKey: _navigatorKey,
  //     home: const OnboardingView(),
  //     onGenerateRoute: (_) => SplashView.route(),
  //   );
  // }
}
