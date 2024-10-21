part of '../../eb_add_schedule.dart';

final class DropdownNotify<T> extends StatelessWidget {
  final String title;
  final double fontSize;

  final List<T> listDropdownValue;
  final Widget Function(T) createMenuItemChild;
  final Function() selectItemAction;
  final List<Widget> Function(BuildContext)? selectedItemBuilder;

  const DropdownNotify({
    super.key,
    required this.title,
    required this.fontSize,
    required this.listDropdownValue,
    required this.createMenuItemChild,
    required this.selectItemAction,
    this.selectedItemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 7),
        Text(
          title,
          style: const TextStyle(
            fontFamily: FontFamily.nanumSquareRegular,
            color: Colors.black87,
            fontSize: 16,
          ),
        ),
        const Spacer(),
        DropdownNotifyButton(
          listDropdownValue: listDropdownValue,
          createMenuItemChild: createMenuItemChild,
          selectItemAction: selectItemAction,
          selectedItemBuilder: selectedItemBuilder,
        ),
      ],
    );
  }
}

final class DropdownNotifyButton<T> extends StatefulWidget {
  final List<T> listDropdownValue;
  final Widget Function(T) createMenuItemChild;
  final Function() selectItemAction;
  final List<Widget> Function(BuildContext)? selectedItemBuilder;

  const DropdownNotifyButton({
    super.key,
    required this.listDropdownValue,
    required this.createMenuItemChild,
    required this.selectItemAction,
    this.selectedItemBuilder,
  });

  @override
  State<StatefulWidget> createState() => DropdownNotifyButtonState<T>();
}

final class DropdownNotifyButtonState<T> extends State<DropdownNotifyButton> {
  late T dropdownValue = widget.listDropdownValue.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      menuMaxHeight: 200,
      value: dropdownValue,
      icon: const Icon(Icons.keyboard_arrow_down),
      elevation: 16,
      style: const TextStyle(
        color: Colors.black,
        fontFamily: FontFamily.nanumSquareBold,
        fontSize: 18,
      ),
      selectedItemBuilder: widget.selectedItemBuilder,
      items: widget.listDropdownValue.map<DropdownMenuItem<T>>(
        (value) {
          final tmpValue = value as T;

          return DropdownMenuItem<T>(
            value: tmpValue,
            child: widget.createMenuItemChild(tmpValue),
          );
        },
      ).toList(),
      onChanged: (T? value) {
        if (value == null) {
          return;
        }
        setState(() {
          dropdownValue = value;
        });
        widget.selectItemAction();
      },
    );
  }
}
