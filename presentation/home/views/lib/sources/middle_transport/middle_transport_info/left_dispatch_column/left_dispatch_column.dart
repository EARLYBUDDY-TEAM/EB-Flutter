part of '../../../../eb_home.dart';

final class _LeftDispatchColumn extends StatelessWidget {
  final EBSubPath trasnportSubPath;

  const _LeftDispatchColumn({
    super.key,
    required this.trasnportSubPath,
  });

  @override
  Widget build(BuildContext context) {
    if (trasnportSubPath.type == 1) {
      return const Text("subway");
    } else {
      return _busContent();
    }
  }

  Widget _busContent() {
    final busList = makeBusList();
    if (busList.isEmpty) {
      return _LeftDispatchColumnContent(
        subPath: trasnportSubPath,
      );
    } else {
      return _LeftDispatchPopupButtonBus(
        busList: busList,
        transportSubPath: trasnportSubPath,
      );
    }
  }

  List<Bus> makeBusList() {
    final List<Bus> busList = [];

    for (var transport in trasnportSubPath.transports) {
      final bus = transport.bus;
      log(bus.toString());
      if (bus != null) {
        busList.add(bus);
      }
    }

    return busList;
  }
}

// final class _LeftDispatchColumnDropDownBus extends StatefulWidget {
//   final EBSubPath trasnportSubPath;
//   final List<Bus> busList;

//   const _LeftDispatchColumnDropDownBus({
//     super.key,
//     required this.trasnportSubPath,
//     required this.busList,
//   });

//   @override
//   State<StatefulWidget> createState() => _LeftDispatchColumnDropDownStateBus();
// }

// final class _LeftDispatchColumnDropDownStateBus
//     extends State<_LeftDispatchColumnDropDownBus> {
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<Bus>(
//       itemHeight: 300,
//       menuMaxHeight: 300,
//       icon: const SizedBox.shrink(),
//       selectedItemBuilder: _selectedItemBuilder(
//         context: context,
//         trasnportSubPath: widget.trasnportSubPath,
//       ),
//       items: _items,
//       onChanged: (selected) {
//         log(selected.toString());
//       },
//     );
//   }
// }

// extension on _LeftDispatchColumnDropDownStateBus {
//   List<Widget> Function(BuildContext) _selectedItemBuilder({
//     required BuildContext context,
//     required EBSubPath trasnportSubPath,
//   }) {
//     return (context) {
//       return widget.busList.map<Widget>((_) {
//         return _LeftDispatchColumnContent(
//           subPath: widget.trasnportSubPath,
//         );
//       }).toList();
//     };
//   }
// }

// extension on _LeftDispatchColumnDropDownStateBus {
//   DropdownMenuItem<Bus> makeDropDownButton(Bus bus) {
//     return DropdownMenuItem(
//       child: Text(bus.number),
//     );
//   }

//   List<DropdownMenuItem<Bus>> get _items {
//     return widget.busList.map<DropdownMenuItem<Bus>>((b) {
//       return makeDropDownButton(b);
//     }).toList();
//   }
// }

final class _LeftDispatchColumnContent extends StatelessWidget {
  final EBSubPath subPath;

  Color get transportColor {
    if (subPath.type == 1) {
      final subway = subPath.transports.firstOrNull?.subway;
      if (subway != null) {
        return subway.color();
      }
    }

    if (subPath.type == 2) {
      final bus = subPath.transports.firstOrNull?.bus;
      if (bus != null) {
        return bus.color();
      }
    }

    return Colors.grey;
  }

  const _LeftDispatchColumnContent({
    super.key,
    required this.subPath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _transportNameContainer(),
            const SizedBox(width: 8),
            _stationNameText(),
          ],
        ),
        _transportTypeText(),
        const SizedBox(height: 10),
        _expectArrivalText(),
      ],
    );
  }
}

extension on _LeftDispatchColumnContent {
  String get transportName {
    if (subPath.type == 1) {
      final transport = subPath.transports.firstOrNull;
      if ((transport != null) && (transport.subway != null)) {
        return transport.subway!.type;
      }
    }

    if (subPath.type == 2) {
      final transport = subPath.transports.firstOrNull;
      if ((transport != null) && (transport.bus != null)) {
        return transport.bus!.number;
      }
    }

    return '-';
  }

  Widget _transportNameContainer() {
    return Container(
      decoration: BoxDecoration(
        color: transportColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Text(
          transportName,
          style: const TextStyle(
            fontFamily: FontFamily.nanumSquareBold,
            color: Colors.white,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

extension on _LeftDispatchColumnContent {
  String get stationName {
    return subPath.startName;
  }

  Widget _stationNameText() {
    return Text(
      stationName,
      style: const TextStyle(
        fontFamily: FontFamily.nanumSquareRegular,
        color: Colors.black87,
        fontSize: 13,
      ),
    );
  }
}

extension on _LeftDispatchColumnContent {
  String get transportType {
    final type = subPath.type;

    switch (type) {
      case 1:
        return "지하철";
      case 2:
        return "버스";
      default:
        return "-";
    }
  }

  Widget _transportTypeText() {
    return Text(
      '$transportType 도착까지',
      style: const TextStyle(
        fontFamily: FontFamily.gmarketSansBold,
        fontSize: 18,
      ),
    );
  }
}

extension on _LeftDispatchColumnContent {
  Widget _expectArrivalText() {
    const double fontSize = 13;

    return const Row(
      children: [
        Text(
          '약속장소에 ',
          style: TextStyle(
            fontFamily: FontFamily.gmarketSansRegular,
            color: Colors.black87,
            fontSize: fontSize,
          ),
        ),
        Text(
          '14:20',
          style: TextStyle(
            fontFamily: FontFamily.gmarketSansBold,
            color: Colors.blue,
            fontSize: fontSize,
          ),
        ),
        Text(
          ' 도착 예정',
          style: TextStyle(
            fontFamily: FontFamily.gmarketSansRegular,
            color: Colors.black87,
            fontSize: fontSize,
          ),
        ),
      ],
    );
  }
}
