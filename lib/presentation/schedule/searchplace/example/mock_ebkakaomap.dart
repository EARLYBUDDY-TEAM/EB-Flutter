part of 'searchplace_example.dart';

class _MockEBKakaoMapView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    EBKakaoMapView(place: Place.mockStarBucks()),
              ),
            );
          },
          child: const Text('Push EBKakaoMapView'),
        ),
      ),
    );
  }
}
