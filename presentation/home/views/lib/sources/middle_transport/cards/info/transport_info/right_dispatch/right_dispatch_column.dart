part of '../../../../../../eb_home.dart';

final class _RightDisPatchColumn extends StatelessWidget {
  final int index;
  final RealTimeInfo? realTimeInfo;

  String convertArrivalIntToString(int? arrivalSec) {
    if (arrivalSec == null) {
      return "-분";
    }

    final minute = arrivalSec ~/ 60;
    return EBTime.intMinuteToString(minute);
  }

  const _RightDisPatchColumn({
    required this.index,
    required this.realTimeInfo,
  });

  @override
  Widget build(BuildContext context) {
    final arrival1 = convertArrivalIntToString(realTimeInfo?.arrivalSec1);
    final arrival2 = convertArrivalIntToString(realTimeInfo?.arrivalSec2);

    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          context
              .read<MiddleTranportBloc>()
              .add(PressReloadButton(selectedIndex: index));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _arrival1Text(arrival1),
              const SizedBox(height: 7),
              _arrival2TextAndReloadButton(arrival2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _arrival2TextAndReloadButton(String arrival2) {
    return Row(
      children: [
        _arrival2Text(arrival2),
        const SizedBox(width: 5),
        _ReloadIconTransportInfoCard(
          realTimeInfo: realTimeInfo,
        ),
      ],
    );
  }

  Widget _arrival1Text(String arrival1) {
    final newArrival1String = (arrival1 == '0분') ? "곧 도착" : arrival1;
    final newColor = (arrival1 == '0분') ? EBColors.error : EBColors.text;

    return Row(
      children: [
        Text(
          newArrival1String,
          style: TextStyle(
            fontFamily: FontFamily.gmarketSansBold,
            fontSize: 46,
            color: newColor,
          ),
        ),
        const SizedBox(width: 3),
      ],
    );
  }

  Widget _arrival2Text(String arrival2) {
    return Text(
      '다음 배차까지 $arrival2전',
      style: const TextStyle(
        fontFamily: FontFamily.nanumSquareRegular,
        color: Colors.black87,
        fontSize: 13,
      ),
    );
  }
}
