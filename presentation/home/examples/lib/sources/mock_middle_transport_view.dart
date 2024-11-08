part of 'home_example.dart';

// final class MockMiddleTransportView extends StatelessWidget {
//   const MockMiddleTransportView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(height: 100),
//               MockMiddleTransportInfoView(),
//               SizedBox(height: 100),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _plain_text() {
//     return const MiddleTransportAddScheduleCard();
//   }

//   Widget _imminent() {
//     return const MiddleTransportArrivalCard();
//   }
// }

// extension on MockMiddleTransportView {
//   Widget _info() {
//     final transportList = mockTransportSubPath.transportList;

//     Transport? selectedTransport;

//     switch (transportList) {
//       case SubwayList():
//         selectedTransport = transportList.subwayList.firstOrNull;
//       case BusList():
//         selectedTransport = transportList.busList.firstOrNull;
//       default:
//         selectedTransport = null;
//     }

//     return MiddleTransportInfoCard(
//       selectedTransport: selectedTransport,
//       curSubPathExpectTime: SubPathExpectTime(
//         subPath: mockTransportSubPath,
//         expectStartTime: DateTime.now(),
//         expectTotalTime: 100,
//       ),
//       streamRealTimeInfo: const Stream.empty(),
//     );
//   }
// }

// final class MockMiddleTransportInfoView extends StatelessWidget {
//   const MockMiddleTransportInfoView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 200,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 20),
//         child: MiddleTransportInfoView(
//           horizontalPadding: 20,
//         ),
//       ),
//     );
//   }
// }
