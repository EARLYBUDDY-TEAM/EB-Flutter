part of '../../../eb_add_schedule.dart';

final class NotifyTransportExpanded extends StatelessWidget {
  const NotifyTransportExpanded({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        _divider(),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _divider() {
    return const Divider(
      color: Colors.grey,
      thickness: 0.5,
    );
  }
}
