part of '../../../eb_add_schedule.dart';

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
        final text = (setting is ChangeAddScheduleSetting)
            ? setting.schedule.title
            : null;

        return _ScheduleTitleTextField(
          color: color,
          fontSize: fontSize,
          initialText: text,
        );
      },
    );
  }
}

final class _ScheduleTitleTextField extends StatefulWidget {
  final Color color;
  final double fontSize;
  String? initialText;

  _ScheduleTitleTextField({
    required this.color,
    required this.fontSize,
    this.initialText,
  });

  @override
  State<StatefulWidget> createState() => _ScheduleTitleTextFieldState();
}

final class _ScheduleTitleTextFieldState
    extends State<_ScheduleTitleTextField> {
  final controller = TextEditingController();

  @override
  void didUpdateWidget(covariant _ScheduleTitleTextField oldWidget) {
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
    return TextField(
      controller: controller,
      onChanged: (title) {
        context.read<AddScheduleBloc>().add(ChangeTitle(title));
      },
      cursorColor: widget.color,
      decoration: InputDecoration(
        labelText: '제목',
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: widget.color,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: widget.color,
          ),
        ),
        labelStyle: TextStyle(
          fontFamily: FontFamily.nanumSquareBold,
          fontSize: widget.fontSize,
          color: widget.color,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
    );
  }
}
