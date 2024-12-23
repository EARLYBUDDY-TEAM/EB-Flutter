part of '../../../eb_add_schedule.dart';

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
        final text = (setting is ChangeAddScheduleSetting)
            ? setting.schedule.memo
            : null;

        return _ScheduleMemoTextField(
          color: color,
          fontSize: fontSize,
          initialText: text,
        );
      },
    );
  }
}

final class _ScheduleMemoTextField extends StatefulWidget {
  final Color color;
  final double fontSize;
  String? initialText;

  _ScheduleMemoTextField({
    required this.color,
    required this.fontSize,
    this.initialText,
  });

  @override
  State<StatefulWidget> createState() => _ScheduleMemoTextFieldState();
}

final class _ScheduleMemoTextFieldState extends State<_ScheduleMemoTextField> {
  final controller = TextEditingController();

  @override
  void didUpdateWidget(covariant _ScheduleMemoTextField oldWidget) {
    if ((oldWidget.initialText != widget.initialText) &&
        (widget.initialText != null)) {
      controller.text = widget.initialText ?? "";
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    if (widget.initialText != null) {
      controller.text = widget.initialText ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 150),
      child: TextField(
        controller: controller,
        onChanged: (memo) =>
            context.read<AddScheduleBloc>().add(ChangeMemo(memo)),
        keyboardType: TextInputType.multiline,
        maxLines: null,
        cursorColor: widget.color,
        decoration: InputDecoration(
          labelText: '메모',
          border: InputBorder.none,
          labelStyle: TextStyle(
            fontFamily: FontFamily.nanumSquareBold,
            fontSize: widget.fontSize,
            color: widget.color,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
      ),
    );
  }
}
