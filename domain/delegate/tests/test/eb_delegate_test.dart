import 'package:flutter_test/flutter_test.dart';
import 'package:eb_delegate/eb_delegate.dart';
import 'package:fake_async/fake_async.dart';
import 'package:eb_state/eb_state.dart';
import 'package:flutter/foundation.dart';

// test("Fake async with microtasks", () {
//     fakeAsync((fa) {
//       int n = 0;
//       var stream = Stream.fromIterable([1, 2, 3, 4, 5]);
//       stream.listen((value) async {
//         n = value;
//         debugPrint(value.toString());
//       });
//       fa.flushMicrotasks();
//       expect(n, 5);
//     });
//   });

void main() {
  test('Test HomeDelegate, Can listen seed data from BehaviorSubject', () {
    fakeAsync((fa) {
      // given
      final List<BaseStatus> expectStatusList = [
        BaseStatus.fail,
        BaseStatus.success,
      ];
      List<BaseStatus> receiveStatusList = [];
      final homeDelegate = HomeDelegate();

      // when
      homeDelegate.loginStatus.add(BaseStatus.fail);
      homeDelegate.loginStatus.listen((receiveStatus) {
        receiveStatusList.add(receiveStatus);
        debugPrint("ReceiveStatus : $receiveStatus");
      });
      homeDelegate.loginStatus.add(BaseStatus.success);
      fa.flushMicrotasks();

      debugPrint(receiveStatusList.toString());
      // // then
      // expect(expectStatus, addStatus);
    });
  });
}
