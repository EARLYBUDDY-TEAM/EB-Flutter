part of '../../eb_register.dart';

final class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('이름'),
        BlocSelector<RegisterBloc, RegisterState, NameState>(
          selector: (state) => state.nameState,
          builder: (context, nameState) {
            final int lenName = nameState.name.value.length;
            final TextFieldStatus status = nameState.status;

            return NameTextField(
              lenName: lenName,
              labelText: '이름을 입력해주세요.',
              errorText: _errorText(status),
              onChanged: (name) =>
                  context.read<RegisterBloc>().add(ChangeName(name)),
            );
          },
        ),
      ],
    );
  }

  String? _errorText(TextFieldStatus status) {
    switch (status) {
      case TextFieldStatus.onError:
        return '30자 이하로 입력해주세요';
      default:
        return null;
    }
  }
}

final class NameTextField extends StatelessWidget {
  final int lenName;
  final Function(String) onChanged;
  final color = EBColors.blue2;
  final String? labelText;
  final String? errorText;

  NameTextField({
    super.key,
    required this.lenName,
    required this.onChanged,
    this.errorText,
    this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      cursorColor: color,
      decoration: NameInputDecoration(
        labelText,
        errorText,
        color,
        lenName: _lenName,
      ),
    );
  }

  String get _lenName {
    return lenName == 0 ? "" : "  $lenName   ";
  }
}

class NameInputDecoration extends EBInputDecoration {
  final String lenName;

  NameInputDecoration(
    super.labelText,
    super.errorText,
    super.color, {
    required this.lenName,
  });

  @override
  Widget? get suffix => Text(
        lenName,
        style: const TextStyle(
          fontFamily: FontFamily.nanumSquareRegular,
          fontSize: 13,
        ),
      );
}
