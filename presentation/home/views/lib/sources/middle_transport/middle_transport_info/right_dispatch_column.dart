part of '../../../eb_home.dart';

final class _RightDisPatchColumn extends StatefulWidget {
  final Stream<RealTimeInfo> stream;

  const _RightDisPatchColumn({
    super.key,
    required this.stream,
  });

  @override
  State<StatefulWidget> createState() => _RightDisPatchColumnState();
}

final class _RightDisPatchColumnState extends State<_RightDisPatchColumn> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.stream,
      builder: (context, snapshot) {
        final arrivalSec1 = snapshot.data?.arrivalSec1;
        final arrivalSec2 = snapshot.data?.arrivalSec2;
        return _RightDisPatchColumnContent(
          arrivalSec1: arrivalSec1,
          arrivalSec2: arrivalSec2,
        );
      },
    );
  }
}

final class _RightDisPatchColumnContent extends StatelessWidget {
  final int? arrivalSec1;
  final int? arrivalSec2;
  String get arrival1 {
    if (arrivalSec1 == null) {
      return "-분";
    }

    final minute = arrivalSec1! ~/ 60;
    return EBTime.intToHourMinuteString(minute);
  }

  String get arrival2 {
    if (arrivalSec2 == null) {
      return "-분";
    }

    final minute = arrivalSec2! ~/ 60;
    return EBTime.intToHourMinuteString(minute);
  }

  const _RightDisPatchColumnContent({
    super.key,
    required this.arrivalSec1,
    required this.arrivalSec2,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Text(
              "$arrival1 전",
              style: const TextStyle(
                fontFamily: FontFamily.gmarketSansBold,
                fontSize: 38,
              ),
            ),
            const SizedBox(width: 5),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Text(
              '다음 배차까지 $arrival2전',
              style: const TextStyle(
                fontFamily: FontFamily.nanumSquareRegular,
                color: Colors.black87,
                fontSize: 13,
              ),
            ),
            const SizedBox(width: 10),
            _ReloadTransportInfoButton(),
          ],
        ),
      ],
    );
  }
}
