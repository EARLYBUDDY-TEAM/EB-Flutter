part of '../../../../../eb_home.dart';

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
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          context
              .read<MiddleTranportBloc>()
              .add(PressReloadButton(selectedIndex: index));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _arrival1Text(arrival1),
              const SizedBox(height: 5),
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
    return Row(
      children: [
        Text(
          arrival1,
          style: const TextStyle(
            fontFamily: FontFamily.gmarketSansBold,
            fontSize: 40,
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
        fontSize: 12,
      ),
    );
  }
}
