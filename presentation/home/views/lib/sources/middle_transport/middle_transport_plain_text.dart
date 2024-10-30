part of '../../eb_home.dart';

final class MiddleTransportAddRoute extends StatelessWidget {
  const MiddleTransportAddRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: const _MiddleTransportPlainText(
        text: "경로 추가하기",
      ),
    );
  }
}

final class MiddleTransportAddSchedule extends StatelessWidget {
  const MiddleTransportAddSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.of(context).push(
        AddScheduleView.pageInitAddSchedule(context: context),
      ),
      child: const _MiddleTransportPlainText(
        text: "일정 추가하기",
      ),
    );
  }
}

final class _MiddleTransportPlainText extends StatelessWidget {
  final String text;

  const _MiddleTransportPlainText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "+ $text",
      style: TextStyle(
        fontFamily: FontFamily.gmarketSansRegular,
        color: EBColors.blue3,
        fontSize: 27,
      ),
    );
  }
}
