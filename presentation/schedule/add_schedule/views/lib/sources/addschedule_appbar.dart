part of '../eb_add_schedule.dart';

final class _AddScheduleAppBar extends AppBar {
  final String titleString;
  final Function() popViewAction;
  final Function()? removeScheduleAction;

  _AddScheduleAppBar({
    required this.titleString,
    required this.popViewAction,
    required this.removeScheduleAction,
  });

  @override
  Widget? get title => Text(
        titleString,
        style: const TextStyle(
          fontFamily: FontFamily.nanumSquareBold,
          fontSize: 18,
        ),
      );

  @override
  Widget? get leading => IconButton(
        onPressed: () => popViewAction(),
        icon: const Icon(Icons.arrow_back_ios_new),
      );

  @override
  List<Widget>? get actions {
    if (removeScheduleAction == null) {
      return null;
    }

    return [
      TextButton(
        onPressed: removeScheduleAction,
        child: const Text(
          '삭제',
          style: TextStyle(
            color: Colors.red,
            fontFamily: FontFamily.nanumSquareBold,
            fontSize: 17,
          ),
        ),
      )
    ];
  }
}
