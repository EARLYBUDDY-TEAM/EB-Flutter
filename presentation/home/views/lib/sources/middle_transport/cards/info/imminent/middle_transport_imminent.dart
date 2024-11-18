part of '../../../../../eb_home.dart';

final class MiddleTransportOverScheduleCard extends StatelessWidget {
  final title = "늦지 않게 출발하셨나요?";

  const MiddleTransportOverScheduleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return MiddleTransportCardForm(
      child: _MiddleTransportImminentCard(
        title: title,
        onPressed: () {},
      ),
    );
  }
}

final class MiddleTransportArrivalCard extends StatelessWidget {
  final title = "곧 도착이에요! 즐거운 시간 되세요😀";

  const MiddleTransportArrivalCard({super.key});

  @override
  Widget build(BuildContext context) {
    return MiddleTransportCardForm(
      child: _MiddleTransportImminentCard(
        title: title,
        onPressed: () {},
      ),
    );
  }
}

final class _MiddleTransportImminentCard extends StatelessWidget {
  final String title;
  final Function() onPressed;

  const _MiddleTransportImminentCard({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: FontFamily.gmarketSansBold,
            fontSize: 19,
            color: EBColors.blue3,
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: const Text(
            "아직 출발 전이에요 >",
            style: TextStyle(
              fontFamily: FontFamily.gmarketSansRegular,
              color: Colors.black54,
              fontSize: 16,
            ),
          ),
        )
      ],
    );
  }
}
