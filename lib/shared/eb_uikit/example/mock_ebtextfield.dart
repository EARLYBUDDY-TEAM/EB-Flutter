part of 'eb_uikit_example.dart';

final class _MockEBTextField extends StatelessWidget {
  const _MockEBTextField();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _EBTextFieldView(
              labelText: 'EBTextField',
              errorText: 'error EBTextField',
              onChanged: (_) {},
            ),
            EBPasswordTextField(
              labelText: 'EBPasswordTextField',
              errorText: 'error EBPasswordTextField',
              onChanged: (_) {},
            )
          ],
        ),
      ),
    ));
  }
}

final class _EBPasswordTextFieldView extends StatefulWidget {
  final String? labelText;
  final String? errorText;
  final Function(String)? onChanged;

  const _EBPasswordTextFieldView({
    this.labelText,
    this.errorText,
    this.onChanged,
  });

  @override
  State<StatefulWidget> createState() => _EBTextFieldState();
}

final class _EBPasswordTextFieldState extends State<_EBPasswordTextFieldView> {
  bool onError = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: EBPasswordTextField(
            labelText: widget.labelText,
            errorText: onError ? widget.errorText : null,
            onChanged: widget.onChanged,
          ),
        ),
        const SizedBox(width: 10),
        TextButton(
          onPressed: () => setState(() {
            log('${widget.labelText} onError : $onError');
            onError = !onError;
          }),
          child: const Text('toggle Error'),
        ),
      ],
    );
  }
}

final class _EBTextFieldView extends StatefulWidget {
  final String? labelText;
  final String? errorText;
  final Function(String)? onChanged;

  const _EBTextFieldView({
    this.labelText,
    this.errorText,
    this.onChanged,
  });

  @override
  State<StatefulWidget> createState() => _EBTextFieldState();
}

final class _EBTextFieldState extends State<_EBTextFieldView> {
  bool onError = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: EBTextField(
            labelText: widget.labelText,
            errorText: onError ? widget.errorText : null,
            onChanged: widget.onChanged,
          ),
        ),
        const SizedBox(width: 10),
        TextButton(
          onPressed: () => setState(() {
            log('${widget.labelText} onError : $onError');
            onError = !onError;
          }),
          child: const Text('toggle Error'),
        ),
      ],
    );
  }
}
