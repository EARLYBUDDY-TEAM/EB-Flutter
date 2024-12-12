part of '../../eb_uikit.dart';

final class WithLoadingView extends StatefulWidget {
  final LoadingDelegate loadingDelegate;
  final Widget child;

  const WithLoadingView({
    super.key,
    required this.child,
    required this.loadingDelegate,
  });

  @override
  State<StatefulWidget> createState() => WithLoadingState();
}

final class WithLoadingState extends State<WithLoadingView> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      initialData: false,
      stream: widget.loadingDelegate.stream,
      builder: (context, snapshot) {
        final bool? isOverlay = snapshot.data;
        return Stack(
          children: [
            widget.child,
            if ((isOverlay != null) && (isOverlay))
              _LoadingView()
            else
              const SizedBox(),
          ],
        );
      },
    );
  }
}

final class _LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          color: Colors.black12.withOpacity(.4),
        ),
        Assets.lotties.loading.lottie(),
      ],
    );
  }
}
