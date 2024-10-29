part of '../findroute_example.dart';

WriteFindRouteSetting makeWriteSetting(BuildContext context) {
  return WriteFindRouteSetting(
    pageChangeStartPlace: makeTextRoute(context: context, text: 'start'),
    pageChangeEndPlace: makeTextRoute(context: context, text: 'end'),
  );
}

ReadFindRouteSetting makeReadSetting(BuildContext context) {
  return ReadFindRouteSetting(subPaths: const []);
}

MaterialPageRoute Function(BuildContext) makeTextRoute({
  required BuildContext context,
  required String text,
}) {
  return makeRoute(
    view: Scaffold(
      body: Center(
        child: Text(text),
      ),
    ),
  );
}

MaterialPageRoute Function(BuildContext) makeRoute({
  required Widget view,
}) {
  return (BuildContext context) => MaterialPageRoute(
        builder: (context) => view,
      );
}
