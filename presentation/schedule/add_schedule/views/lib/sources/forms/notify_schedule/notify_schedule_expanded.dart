part of '../../../eb_add_schedule.dart';

final class NotifyScheduleExpanded extends StatelessWidget {
  const NotifyScheduleExpanded({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        const FormDivider(),
        const SizedBox(height: 10),
        DropdownNotifyBeforeScheduleStart(),
      ],
    );
  }
}

final class DropdownNotifyBeforeScheduleStart extends StatelessWidget {
  final listDropdownValue = [for (var i = 1; i <= 12; i++) i * 10];
  Widget createMenuItemChild(dynamic value) {
    return Text("$value분 전");
  }

  DropdownNotifyBeforeScheduleStart({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownNotify<int>(
      title: '일정 시작 알림',
      fontSize: 17,
      listDropdownValue: listDropdownValue,
      createMenuItemChild: createMenuItemChild,
      selectItemAction: () {},
    );
  }
}
