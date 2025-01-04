part of '../../../eb_add_schedule.dart';

final class NotifyTransportExpanded extends StatelessWidget {
  final int initialBeforeNotifyMinute;
  final int initialBeforeNotifyMinuteRange;

  const NotifyTransportExpanded({
    super.key,
    required this.initialBeforeNotifyMinute,
    required this.initialBeforeNotifyMinuteRange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        const FormDivider(),
        const SizedBox(height: 10),
        DropdownNotifyBeforeTransportStart(
          initialBeforeNotifyMinute: initialBeforeNotifyMinute,
        ),
        const SizedBox(height: 10),
        DropdownNotifyRangeTranasportAlert(
          initialBeforeNotifyMinuteRange: initialBeforeNotifyMinuteRange,
        ),
      ],
    );
  }
}

final class DropdownNotifyBeforeTransportStart extends StatelessWidget {
  final int initialBeforeNotifyMinute;

  final listDropdownValue = [for (var i = 1; i <= 60; i++) i];
  Widget createMenuItemChild(dynamic value) {
    return Text("$value분 전");
  }

  DropdownNotifyBeforeTransportStart({
    super.key,
    required this.initialBeforeNotifyMinute,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownNotify<int>(
      initialValue: initialBeforeNotifyMinute,
      title: '배차 몇 분전 알림 받기',
      fontSize: 17,
      listDropdownValue: listDropdownValue,
      createMenuItemChild: createMenuItemChild,
      selectItemAction: (dynamic selectedItem) {
        context.read<AddScheduleBloc>().add(
              SetTrueNotifyTransportState(
                beforeNotifyMinute: selectedItem,
              ),
            );
      },
    );
  }
}

final class DropdownNotifyRangeTranasportAlert extends StatelessWidget {
  final int initialBeforeNotifyMinuteRange;
  final listDropdownValue = [for (var i = 1; i <= 12; i++) i * 10];
  Widget createMenuItemChild(dynamic value) {
    return Text("$value분 전");
  }

  DropdownNotifyRangeTranasportAlert({
    super.key,
    required this.initialBeforeNotifyMinuteRange,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownNotify<int>(
      initialValue: initialBeforeNotifyMinuteRange,
      title: '알림 범위',
      fontSize: 17,
      listDropdownValue: listDropdownValue,
      createMenuItemChild: createMenuItemChild,
      selectedItemBuilder: (context) {
        return List.generate(
          listDropdownValue.length,
          (index) {
            final value = listDropdownValue[index];
            return Row(
              children: [
                Text("출발예정 $value분 전부터"),
              ],
            );
          },
        );
      },
      selectItemAction: (dynamic selectedItem) {
        context.read<AddScheduleBloc>().add(
              SetTrueNotifyTransportState(
                beforeNotifyMinuteRange: selectedItem,
              ),
            );
      },
    );
  }
}
