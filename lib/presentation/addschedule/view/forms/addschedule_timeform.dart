part of '../addschedule_view.dart';

class _TimeForm extends StatelessWidget {
  final double fontSize;

  const _TimeForm({
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return _RoundRectForm(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            _IconPlusName(
              name: '시간',
              iconData: Icons.access_time,
              fontSize: fontSize,
              isActive: true,
            ),
            const Spacer(),
            _DateTimePicker()
          ],
        ),
      ),
    );
  }
}

class _DateTimePicker extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<_DateTimePicker> {
  DateTime dateTime = DateTime.now();

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 250,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system
        // navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () => _showDialog(
        CupertinoDatePicker(
          initialDateTime: dateTime,
          use24hFormat: true,
          onDateTimeChanged: (DateTime newDateTime) {
            setState(() {
              dateTime = newDateTime;
            });
          },
        ),
      ),
      child: _DateTimeText(dateTime: dateTime),
    );
  }
}

class _DateTimeText extends StatelessWidget {
  DateTime dateTime;

  _DateTimeText({required this.dateTime});

  @override
  Widget build(BuildContext context) {
    return Text(
        '${dateTime.year}년 ${dateTime.month}월 ${dateTime.day}일 ${dateTime.hour}:${dateTime.minute}');
  }
}
