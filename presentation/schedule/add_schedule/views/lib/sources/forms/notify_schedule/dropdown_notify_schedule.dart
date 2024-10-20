part of '../../../eb_add_schedule.dart';

final class DropdownNotify extends StatelessWidget {
  final String title;
  final double fontSize;

  const DropdownNotify({
    super.key,
    required this.title,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _IconPlusName(
          name: '일정알림',
          iconData: CupertinoIcons.bell,
          fontSize: fontSize,
          isActive: true,
        ),
        const Spacer(),
        _NotifyScheduleSwitch()
      ],
    );
  }
}

final class DropdownNotifySchedule extends StatefulWidget {
  final listDropdownNotifySchedule = [for (var i = 1; i <= 12; i++) i * 10];

  DropdownNotifySchedule({super.key});

  @override
  State<DropdownNotifySchedule> createState() => _DropdownNotifyScheduleState();
}

final class _DropdownNotifyScheduleState extends State<DropdownNotifySchedule> {
  late int dropdownValue = widget.listDropdownNotifySchedule.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      menuMaxHeight: 200,
      value: dropdownValue,
      icon: const Icon(Icons.keyboard_arrow_down),
      elevation: 16,
      style: const TextStyle(
        color: Colors.black,
        fontFamily: FontFamily.nanumSquareBold,
        fontSize: 18,
      ),
      onChanged: (int? value) {
        setState(() {
          dropdownValue = value!;
        });
        context.read<AddScheduleBloc>().add(
              ChangeNotifySchedule(
                notifyScheduleState:
                    TrueNotifyScheduleState(beforeNotifyMinute: value!),
              ),
            );
      },
      items: _items,
    );
  }

  List<DropdownMenuItem<int>>? get _items {
    return widget.listDropdownNotifySchedule.map<DropdownMenuItem<int>>(
      (int value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Text("$value분 전"),
        );
      },
    ).toList();
  }
}
