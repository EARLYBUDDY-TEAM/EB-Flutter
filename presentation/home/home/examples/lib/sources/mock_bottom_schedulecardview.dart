part of 'home_example.dart';

// final class MockBottomScheduleCardExample extends StatelessWidget {
//   const MockBottomScheduleCardExample({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: EBTheme().light(),
//       home: Scaffold(
//         body: SingleChildScrollView(
//           child: _MockBottomScheduleCardListView(),
//         ),
//       ),
//     );
//   }
// }

// final longTitleSchedule = Schedule(
//   id: 10,
//   title: "MockTitle" * 20,
//   time: DateTime.now(),
//   endPlace: Place.mockView(),
// );

// final class _MockBottomScheduleCardListView extends StatelessWidget {
//   final items = List<Schedule>.generate(20, (i) {
//     bool flag = (i + 1) % 2 == 0 ? true : false;
//     return flag ? longTitleSchedule : Schedule.mock();
//   });
//   final double horizontalPadding = 20;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//         vertical: 100,
//         horizontal: horizontalPadding,
//       ),
//       child: HomeBottomListContent(
//         horizontalPadding: horizontalPadding,
//         schedulePathList: items,
//       ),
//     );
//   }
// }
