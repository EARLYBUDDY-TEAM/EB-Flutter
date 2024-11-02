part of '../../eb_home.dart';

final class MiddleTransportInfo extends StatelessWidget {
  final Stream<RealTimeInfo> stream;

  const MiddleTransportInfo({
    super.key,
    required this.stream,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _leftTranportColumn(),
        _RightDisPatchColumn(
          stream: stream,
        ),
      ],
    );
  }

  Widget _leftTranportColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                child: Text(
                  '강남06',
                  style: TextStyle(
                    fontFamily: FontFamily.nanumSquareBold,
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            const Text(
              '삼성의료원 후문',
              style: TextStyle(
                fontFamily: FontFamily.nanumSquareRegular,
                color: Colors.black87,
                fontSize: 13,
              ),
            ),
          ],
        ),
        const Text(
          '버스 도착까지',
          style: TextStyle(
            fontFamily: FontFamily.gmarketSansBold,
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Row(
          children: [
            Text(
              '약속장소에 ',
              style: TextStyle(
                fontFamily: FontFamily.gmarketSansRegular,
                color: Colors.black87,
              ),
            ),
            Text(
              '14:20',
              style: TextStyle(
                fontFamily: FontFamily.gmarketSansBold,
                color: Colors.blue,
              ),
            ),
            Text(
              ' 도착 예정',
              style: TextStyle(
                fontFamily: FontFamily.gmarketSansRegular,
                color: Colors.black87,
              ),
            ),
          ],
        )
      ],
    );
  }
}

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
      children: [
        Text(
          "$arrival1 전",
          style: const TextStyle(
            fontFamily: FontFamily.gmarketSansBold,
            fontSize: 35,
          ),
        ),
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

final class _ReloadTransportInfoButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          log("ehifowehfioew");
        },
        child: Container(
          width: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey),
          ),
          child: const Icon(
            Icons.replay_outlined,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
