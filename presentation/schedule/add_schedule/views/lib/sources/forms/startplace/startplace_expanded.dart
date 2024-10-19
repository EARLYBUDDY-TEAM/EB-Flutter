part of '../../../eb_add_schedule.dart';

final class StartPlaceExpanded extends StatelessWidget {
  const StartPlaceExpanded({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddScheduleBloc, AddScheduleState>(
      buildWhen: (previous, current) {
        final flag1 = (previous.startPlaceState != current.startPlaceState);
        final flag2 = (current.startPlaceState is SelectedStartPlaceState);
        return (flag1 && flag2);
      },
      builder: (context, state) {
        final selectedStartPlaceState =
            state.startPlaceState as SelectedStartPlaceState;
        final pathInfo = selectedStartPlaceState.pathInfo;
        final pathTime = pathInfo.ebPath.time;
        final pathType = pathInfo.ebPath.type;
        final lineOfPath = pathInfo.transportLineOfPath;
        final address = pathInfo.startPlace.address;

        return Column(
          children: [
            const SizedBox(height: 10),
            _divider(),
            const SizedBox(height: 10),
            _requiredTime(pathTime: pathTime, pathType: pathType),
            const SizedBox(height: 10),
            _transportLine(lineOfPath: lineOfPath, pathTime: pathTime),
            _expectStartTime(),
            const SizedBox(height: 10),
            _endPlaceInfo(address: address),
          ],
        );
      },
    );
  }
}

extension on StartPlaceExpanded {
  Widget _divider() {
    return const Divider(
      color: Colors.grey,
      thickness: 0.5,
    );
  }
}

extension on StartPlaceExpanded {
  Widget _requiredTime({
    required int pathTime,
    required int pathType,
  }) {
    return Row(
      children: [
        Text(
          EBTime.intToString(pathTime),
          style: const TextStyle(
            fontFamily: FontFamily.nanumSquareBold,
            fontSize: 20,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          _stringPathType(pathType),
          style: const TextStyle(
            fontFamily: FontFamily.nanumSquareBold,
            fontSize: 13,
            color: Colors.black87,
          ),
        ),
        const Spacer(),
        _changeRouteButton(),
      ],
    );
  }

  Widget _changeRouteButton() {
    return EBRoundedButton(
      text: "경로 변경",
      onPressed: () {},
    );
  }

  String _stringPathType(int pathType) {
    if (pathType == 1) {
      return '지하철';
    } else if (pathType == 2) {
      return '버스';
    } else {
      return '지하철 + 버스';
    }
  }
}

extension on StartPlaceExpanded {
  Widget _transportLine({
    required TransportLineOfPath lineOfPath,
    required int pathTime,
  }) {
    return SelectRouteItemLine(
      lineOfPath: lineOfPath,
      pathTime: pathTime,
    );
  }
}

extension on StartPlaceExpanded {
  Widget _expectStartTime() {
    return const Row(
      children: [
        Text(
          "출발예정 : ",
          style: TextStyle(
            fontFamily: FontFamily.nanumSquareRegular,
            fontSize: 13,
            color: Colors.black45,
          ),
        ),
        Text(
          "약 10시 50분",
          style: TextStyle(
            fontFamily: FontFamily.nanumSquareBold,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}

extension on StartPlaceExpanded {
  Widget _endPlaceInfo({
    required String address,
  }) {
    return Row(
      children: [
        const Text(
          "출발장소 : ",
          style: TextStyle(
            fontFamily: FontFamily.nanumSquareRegular,
            fontSize: 13,
            color: Colors.black45,
          ),
        ),
        Text(
          address,
          style: const TextStyle(
            fontFamily: FontFamily.nanumSquareBold,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}

// final class ChangeRouteButton extends StatelessWidget {
//   const ChangeRouteButton({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return EBRoundedButton(
//       text: "경로 변경",
//       onPressed: () => _onPressed(context),
//     );
//   }

//   void _onPressed(BuildContext context) {
//     showCupertinoModalBottomSheet(
//       context: context,
//       expand: true,
//       backgroundColor: Colors.white,
//       builder: (_) => _searchPlaceView(endPlace),
//     );
//   }
// }
