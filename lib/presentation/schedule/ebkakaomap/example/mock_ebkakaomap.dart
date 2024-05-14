part of 'ebkakaomap_example.dart';

class MockEBKakaoMapView extends StatelessWidget {
  const MockEBKakaoMapView({super.key});

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
