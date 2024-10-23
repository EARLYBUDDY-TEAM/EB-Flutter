part of '../../eb_add_schedule.dart';

class _ScheduleNameForm extends StatelessWidget {
  final Color color = Colors.grey;
  final double fontSize;

  const _ScheduleNameForm({
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return RoundRectForm(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        child: Column(
          children: [
            _ScheduleTitleInput(
              color: color,
              fontSize: fontSize,
            ),
            _ScheduleMemoInput(
              color: color,
              fontSize: fontSize,
            ),
          ],
        ),
      ),
    );
  }
}

final class _ScheduleMemoInput extends StatelessWidget {
  final Color color;
  final double fontSize;

  const _ScheduleMemoInput({
    required this.color,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddScheduleBloc, AddScheduleState,
        SealedAddScheduleSetting>(
      selector: (state) {
        return state.setting;
      },
      builder: (context, setting) {
        final text = (setting is ChangeScheduleSetting)
            ? setting.initialSchedule.memo
            : null;

        return Container(
          constraints: const BoxConstraints(maxHeight: 150),
          child: TextField(
            controller: TextEditingController(text: text),
            onChanged: (memo) =>
                context.read<AddScheduleBloc>().add(ChangeMemo(memo)),
            keyboardType: TextInputType.multiline,
            maxLines: null,
            cursorColor: color,
            decoration: InputDecoration(
              labelText: '메모',
              border: InputBorder.none,
              labelStyle: TextStyle(
                fontFamily: FontFamily.nanumSquareBold,
                fontSize: fontSize,
                color: color,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
          ),
        );
      },
    );
  }
}

final class _ScheduleTitleInput extends StatelessWidget {
  final Color color;
  final double fontSize;

  const _ScheduleTitleInput({
    required this.color,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddScheduleBloc, AddScheduleState,
        SealedAddScheduleSetting>(
      selector: (state) {
        return state.setting;
      },
      builder: (context, setting) {
        final text = (setting is ChangeScheduleSetting)
            ? setting.initialSchedule.title
            : null;

        return TextField(
          controller: TextEditingController(text: text),
          onChanged: (title) =>
              context.read<AddScheduleBloc>().add(ChangeTitle(title)),
          cursorColor: color,
          decoration: InputDecoration(
            labelText: '제목',
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: color,
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: color,
              ),
            ),
            labelStyle: TextStyle(
              fontFamily: FontFamily.nanumSquareBold,
              fontSize: fontSize,
              color: color,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
        );
      },
    );
  }
}
