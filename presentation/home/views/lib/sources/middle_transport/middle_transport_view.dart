part of '../../eb_home.dart';

final class _MiddleTransportView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeBloc, HomeState, HomeState>(
      selector: (state) => state,
      builder: (context, state) {
        return const MiddleTransportForm(
          content: MiddleTransportInfo(),
        );
      },
    );
  }
}

final class MiddleTransportForm extends StatelessWidget {
  final Widget content;

  const MiddleTransportForm({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: content,
      ),
    );
  }
}
