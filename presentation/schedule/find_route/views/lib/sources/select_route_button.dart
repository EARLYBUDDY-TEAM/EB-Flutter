part of '../eb_find_route.dart';

final class _SelectRouteButton extends StatelessWidget {
  final double horizontalInset = 20;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = ScreenSize.safeArea.bottom(context) + horizontalInset;

    return Padding(
      padding: EdgeInsets.only(
        left: horizontalInset,
        right: horizontalInset,
        bottom: bottomPadding,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          EBButton(
            name: "경로 선택",
            onPressed: () => context
                .read<FindRouteBloc>()
                .add(const PressSelectRouteButton()),
          ),
        ],
      ),
    );
  }
}
