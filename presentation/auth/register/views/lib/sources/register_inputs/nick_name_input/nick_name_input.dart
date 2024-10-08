part of '../../../eb_register.dart';

final class _NameInput extends StatelessWidget {
  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('닉네임'),
            const Spacer(),
            EBRoundedButton(
              text: "추천",
              onPressed: () => context
                  .read<RegisterBloc>()
                  .add(const PressRecommendNickNameButton()),
            ),
          ],
        ),
        BlocSelector<RegisterBloc, RegisterState, NickNameState>(
          selector: (state) => state.nickNameState,
          builder: (context, nameState) {
            final currentText = nameState.nickName.value;
            _textEditingController.text = currentText;
            final lenNickName = currentText.length;
            final TextFieldStatus status = nameState.status;

            return _NickNameStateful(
              textEditingController: _textEditingController,
              lenNickName: lenNickName,
              labelText: '닉네임을 입력해주세요.',
              errorText: _errorText(status),
              onChanged: (nickName) =>
                  context.read<RegisterBloc>().add(ChangeNickName(nickName)),
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
