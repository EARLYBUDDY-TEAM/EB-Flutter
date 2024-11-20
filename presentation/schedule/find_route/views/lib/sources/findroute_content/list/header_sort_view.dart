part of '../../../eb_find_route.dart';

final class _FindRouteHeaderSortView extends StatelessWidget {
  final double height;

  const _FindRouteHeaderSortView({
    super.key,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border.symmetric(
          horizontal: BorderSide(
            color: Colors.grey.withOpacity(0.5),
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: _FindRouteHeaderSortContent(),
      ),
    );
  }
}

final class _FindRouteHeaderSortContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FindRouteBloc, FindRouteState>(
      buildWhen: (previous, current) {
        return previous.contentStatus != current.contentStatus;
      },
      builder: (context, state) {
        return Row(
          children: _children(state.contentStatus),
        );
      },
    );
  }

  List<Widget> _children(SealedFindRouteContentStatus contentStatus) {
    List<Widget> content = [
      _arrivalInfo(minutes: 100),
      const Spacer(),
    ];

    if (contentStatus is DetailFindRouteStatus) {
      final pathTime = contentStatus.path.time;
      final pathType = contentStatus.path.type;
      content.add(
        _pathInfo(
          pathTime: pathTime,
          pathType: pathType,
        ),
      );
    }

    return content;
  }

  Widget _pathInfo({
    required int pathTime,
    required int pathType,
  }) {
    final timeString = EBTime.intMinuteToString(pathTime);
    final pathTypeString = _getPathType(pathType);

    return DefaultTextStyle(
      style: TextStyle(
        fontFamily: FontFamily.nanumSquareBold,
        color: EBColors.text,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            pathTypeString,
          ),
          const SizedBox(height: 10),
          Text(
            timeString,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  String _getPathType(int pathType) {
    if (pathType == 1) {
      return '지하철';
    } else if (pathType == 2) {
      return '버스';
    } else {
      return '지하철 + 버스';
    }
  }

  Widget _arrivalInfo({required int minutes}) {
    final expectArrivalTime = DateTime.now().add(Duration(minutes: minutes));

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _date(expectArrivalTime),
        const SizedBox(height: 3),
        _hour(),
      ],
    );
  }

  Text _date(DateTime expectArrivalTime) {
    return const Text(
      '12월 21일 (토요일)',
      style: TextStyle(
        color: Colors.black54,
        fontFamily: FontFamily.nanumSquareBold,
        fontSize: 15,
      ),
    );
  }

  RichText _hour() {
    return RichText(
      text: TextSpan(
        text: '오전 12:20',
        style: TextStyle(
          color: EBColors.blue2,
          fontFamily: FontFamily.nanumSquareExtraBold,
          fontSize: 19,
        ),
        children: const [
          TextSpan(
            text: ' 도착',
            style: TextStyle(
              color: Colors.black54,
              fontFamily: FontFamily.nanumSquareExtraBold,
              fontSize: 19,
            ),
          )
        ],
      ),
    );
  }
}
