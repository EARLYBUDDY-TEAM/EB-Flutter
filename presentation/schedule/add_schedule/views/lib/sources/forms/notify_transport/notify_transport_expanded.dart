part of '../../../eb_add_schedule.dart';

final class NotifyTransportExpanded extends StatelessWidget {
  const NotifyTransportExpanded({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        const FormDivider(),
        const SizedBox(height: 10),
        DropdownNotifyBeforeTransportStart(),
        const SizedBox(height: 10),
        DropdownNotifyRangeTranasportAlert(),
      ],
    );
  }
}

final class DropdownNotifyBeforeTransportStart extends StatelessWidget {
  final listDropdownValue = [for (var i = 1; i <= 12; i++) i * 10];
  Widget createMenuItemChild(dynamic value) {
    return Text("$value분 전");
  }

  DropdownNotifyBeforeTransportStart({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownNotify<int>(
      title: '배차 몇 분전 알림 받기',
      fontSize: 17,
      listDropdownValue: listDropdownValue,
      createMenuItemChild: createMenuItemChild,
      selectItemAction: () {},
    );
  }
}

final class DropdownNotifyRangeTranasportAlert extends StatelessWidget {
  final listDropdownValue = [for (var i = 1; i <= 12; i++) i * 10];
  Widget createMenuItemChild(dynamic value) {
    return Text("$value분 전");
  }

  DropdownNotifyRangeTranasportAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownNotify<int>(
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
      selectItemAction: () {},
    );
  }
}
