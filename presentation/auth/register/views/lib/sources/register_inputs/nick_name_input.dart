part of '../../eb_register.dart';

final class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('닉네임'),
        BlocSelector<RegisterBloc, RegisterState, NickNameState>(
          selector: (state) => state.nickNameState,
          builder: (context, nameState) {
            final int lenNickName = nameState.nickName.value.length;
            final TextFieldStatus status = nameState.status;

            return NameTextField(
              lenNickName: lenNickName,
              labelText: '닉네임을 입력해주세요.',
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
        return '50자 이하로 입력해주세요';
      default:
        return null;
    }
  }
}

final class NameTextField extends StatelessWidget {
  final int lenNickName;
  final Function(String) onChanged;
  final color = EBColors.blue2;
  final String? labelText;
  final String? errorText;

  NameTextField({
    super.key,
    required this.lenNickName,
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
        lenNickName: _lenName,
      ),
    );
  }

  String get _lenName {
    return lenNickName == 0 ? "" : "  $lenNickName   ";
  }
}

class NameInputDecoration extends EBInputDecoration {
  final String lenNickName;

  NameInputDecoration(
    super.labelText,
    super.errorText,
    super.color, {
    required this.lenNickName,
  });

  @override
  Widget? get suffix => Text(
        lenNickName,
        style: const TextStyle(
          fontFamily: FontFamily.nanumSquareRegular,
          fontSize: 13,
        ),
      );
}
