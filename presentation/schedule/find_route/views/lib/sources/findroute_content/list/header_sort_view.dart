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
      _arrivalInfo(),
      const Spacer(),
    ];

    if (contentStatus is DetailFindRouteStatus) {
      content.add(_pathInfo());
    }

    return content;
  }

  Widget _pathInfo() {
    return DefaultTextStyle(
      style: TextStyle(
          fontFamily: FontFamily.nanumSquareBold, color: EBColors.text),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('버스 + 지하철'),
          SizedBox(height: 10),
          Text(
            '1시간 30분',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _arrivalInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _date(),
        const SizedBox(height: 3),
        _hour(),
      ],
    );
  }

  Text _date() {
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
