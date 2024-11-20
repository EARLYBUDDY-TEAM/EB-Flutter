part of '../../../../../../eb_find_route.dart';

final class _DetailStartInfoPopupButton extends StatelessWidget {
  final TransportMap transportMap;
  final List<RealTimeInfo>? realTimeInfoList;
  final String startName;
  final double fontSize;

  const _DetailStartInfoPopupButton({
    super.key,
    required this.startName,
    required this.fontSize,
    required this.transportMap,
    required this.realTimeInfoList,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<DetailRouteBloc, DetailRouteState, Transport?>(
      selector: (state) => state.selectedTransport,
      builder: (context, selectedTransport) {
        return TransportPopupButton(
          popupButtonContent: _popupButtonContent(
            selectedTransport: selectedTransport,
          ),
          selectAction: _selectAction(context),
          transportMap: transportMap,
          realTimeInfoList: realTimeInfoList,
          selectedTransport: selectedTransport,
        );
      },
    );
  }

  Widget _popupButtonContent({
    required Transport? selectedTransport,
  }) {
    return _DetailStartInfoPopupButtonContent(
      selectedTransport: selectedTransport,
      startName: startName,
      fontSize: fontSize,
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
  final String startName;
  final double fontSize;

  const _DetailStartInfoPopupButtonContent({
    super.key,
    required this.selectedTransport,
    required this.startName,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _startInfo(),
        const SizedBox(height: 5),
        _realTimeInfo(),
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

  Widget _realTimeInfo() {
    return Text(
      "14분 후, 28분 후",
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
