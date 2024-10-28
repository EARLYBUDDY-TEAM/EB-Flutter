part of '../../../eb_add_schedule.dart';

final class NotifyScheduleExpanded extends StatelessWidget {
  final int initialBeforeNotifyMinute;

  const NotifyScheduleExpanded({
    super.key,
    required this.initialBeforeNotifyMinute,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        const FormDivider(),
        const SizedBox(height: 10),
        DropdownNotifySchedule(
          initialBeforeNotifyMinute: initialBeforeNotifyMinute,
        ),
      ],
    );
  }
}

final class DropdownNotifySchedule extends StatelessWidget {
  final int initialBeforeNotifyMinute;

  final listDropdownValue = [for (var i = 1; i <= 12; i++) i * 10];
  Widget createMenuItemChild(dynamic value) {
    return Text("$value분 전");
  }

  DropdownNotifySchedule({
    super.key,
    required this.initialBeforeNotifyMinute,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownNotify<int>(
      initialValue: initialBeforeNotifyMinute,
      title: '일정 시작 알림',
      fontSize: 17,
      listDropdownValue: listDropdownValue,
      createMenuItemChild: createMenuItemChild,
      selectItemAction: (dynamic selectedItem) {
        context.read<AddScheduleBloc>().add(
              ChangeNotifySchedule(
                notifyScheduleState: TrueNotifyScheduleState(
                  beforeNotifyMinute: selectedItem,
                ),
              ),
            );
      },
    );
  }
}
