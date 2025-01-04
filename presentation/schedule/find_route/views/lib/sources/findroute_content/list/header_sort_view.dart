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
          children: _children(
            contentStatus: state.contentStatus,
            scheduleTime: state.scheduleTime,
          ),
        );
      },
    );
  }

  List<Widget> _children({
    required SealedFindRouteContentStatus contentStatus,
    required DateTime scheduleTime,
  }) {
    List<Widget> content = [
      _arrivalInfo(scheduleTime: scheduleTime),
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

  Widget _arrivalInfo({
    required DateTime scheduleTime,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _date(scheduleTime),
        const SizedBox(height: 3),
        _hour(scheduleTime),
      ],
    );
  }

  Text _date(DateTime scheduleTime) {
    final nameOfDay = scheduleTime.getNameOfDay();
    final dateString =
        "${scheduleTime.month}월 ${scheduleTime.day}일 ($nameOfDay)";
    return Text(
      dateString,
      style: const TextStyle(
        color: Colors.black54,
        fontFamily: FontFamily.nanumSquareBold,
        fontSize: 15,
      ),
    );
  }

  RichText _hour(DateTime scheduleTime) {
    final scheduleTimeOfDay = EBTime.dateTimeToTimeOfDay(scheduleTime);
    final scheduleTimeString = EBTime.toHour(scheduleTimeOfDay);

    return RichText(
      text: TextSpan(
        text: scheduleTimeString,
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
