part of '../../../../../../eb_find_route.dart';

final class _DetailStartInfoPopupButton extends StatelessWidget {
  final TransportMap transportMap;
  final String startName;
  final double fontSize;

  const _DetailStartInfoPopupButton({
    super.key,
    required this.startName,
    required this.fontSize,
    required this.transportMap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailRouteBloc, DetailRouteState>(
      builder: (context, state) {
        final selectedTransport = state.selectedTransport;
        final streamRealTimeInfo = state.streamRealTimeInfo;

        return StreamBuilder(
          stream: streamRealTimeInfo,
          builder: (context, snapshot) {
            final realTimeInfoList = snapshot.data;
            final realTimeInfo = RealTimeInfo.getRealTimeInfo(
              realTimeInfoList: realTimeInfoList,
              selectedTransport: selectedTransport,
            );

            return TransportPopupButton(
              popupButtonContent: _popupButtonContent(
                selectedTransport: selectedTransport,
                realTimeInfo: realTimeInfo,
              ),
              selectAction: _selectAction(context),
              transportMap: transportMap,
              realTimeInfoList: realTimeInfoList,
              selectedTransport: selectedTransport,
            );
          },
        );
      },
    );
  }

  Widget _popupButtonContent({
    required Transport? selectedTransport,
    required RealTimeInfo? realTimeInfo,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
      child: _DetailStartInfoPopupButtonContent(
        selectedTransport: selectedTransport,
        realTimeInfo: realTimeInfo,
        startName: startName,
        fontSize: fontSize,
      ),
    );
  }

  Function(Transport) _selectAction(BuildContext context) {
    return (Transport selected) {
      context.read<DetailRouteBloc>().add(
            SelectTransport(selected: selected),
          );
    };
  }
}

final class _DetailStartInfoPopupButtonContent extends StatelessWidget {
  final Transport? selectedTransport;
  final RealTimeInfo? realTimeInfo;
  final String startName;
  final double fontSize;

  const _DetailStartInfoPopupButtonContent({
    super.key,
    required this.selectedTransport,
    required this.startName,
    required this.fontSize,
    required this.realTimeInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _startInfo(),
        const SizedBox(height: 5),
        _realTimeInfo(
          arrivalSec1: realTimeInfo?.arrivalSec1,
          arrivalSec2: realTimeInfo?.arrivalSec2,
        ),
      ],
    );
  }

  Widget _startInfo() {
    return Row(
      children: [
        _StartTransportNumber(
          transport: selectedTransport,
          fontSize: fontSize - 2,
        ),
        const SizedBox(width: 8),
        Text(
          startName,
          style: TextStyle(
            fontFamily: FontFamily.nanumSquareBold,
            fontSize: fontSize,
            color: EBColors.text,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  String _arrivalSecToString(int? arrivalSec) {
    final tmpTime =
        (arrivalSec == null) ? "-분" : EBTime.intSecToString(arrivalSec);
    final time = (tmpTime == '0분') ? '곧 도착' : tmpTime;
    return time;
  }

  Widget _realTimeInfo({
    required int? arrivalSec1,
    required int? arrivalSec2,
  }) {
    final arrival1 = _arrivalSecToString(arrivalSec1);
    final arrival2 = _arrivalSecToString(arrivalSec2);

    return Text(
      "$arrival1, $arrival2",
      style: TextStyle(
        fontFamily: FontFamily.nanumSquareRegular,
        fontSize: 15,
        color: EBColors.error,
      ),
    );
  }
}

final class _StartTransportNumber extends StatelessWidget {
  final Transport? transport;
  final double fontSize;

  const _StartTransportNumber({
    super.key,
    required this.transport,
    required this.fontSize,
  });

  /*
  한글일때 마지막글자 패딩값
  */

  Color get transportColor {
    return transport?.getColor() ?? Colors.grey;
  }

  String get transportName {
    return transport?.getName() ?? "-";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
      decoration: BoxDecoration(
        color: transportColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: Center(
        child: Text(
          transportName,
          style: TextStyle(
            fontFamily: FontFamily.nanumSquareExtraBold,
            fontSize: fontSize,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
