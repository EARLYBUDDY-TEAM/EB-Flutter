part of 'addschedule_example.dart';

final class MockScheduleNameForm extends StatelessWidget {
  const MockScheduleNameForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: ScheduleNameForm(fontSize: 18),
    );
  }
}
