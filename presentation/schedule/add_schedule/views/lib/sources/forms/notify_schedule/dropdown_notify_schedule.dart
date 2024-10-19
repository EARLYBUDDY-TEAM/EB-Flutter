part of '../../../eb_add_schedule.dart';

final listDropdownNotifySchedule = [for (var i = 1; i <= 12; i++) i * 10];

final class DropdownNotifySchedule extends StatefulWidget {
  const DropdownNotifySchedule({super.key});

  @override
  State<DropdownNotifySchedule> createState() => _DropdownNotifyScheduleState();
}

class _DropdownNotifyScheduleState extends State<DropdownNotifySchedule> {
  int dropdownValue = listDropdownNotifySchedule.first;

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
    return listDropdownNotifySchedule.map<DropdownMenuItem<int>>(
      (int value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Text("$value분 전"),
        );
      },
    ).toList();
  }
}
