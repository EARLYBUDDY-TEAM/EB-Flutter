part of '../../../../eb_find_route.dart';

class _ListDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Divider(
        color: Colors.grey.withOpacity(0.5),
        height: 1,
      ),
    );
  }
}
