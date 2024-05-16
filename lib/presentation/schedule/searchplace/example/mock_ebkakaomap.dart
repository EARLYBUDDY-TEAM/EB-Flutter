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

class _MockTestShadow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: LayoutBuilder(
        builder: (context, constraints) => Stack(
          children: [
            Container(
              ///background image
              color: Colors.pink,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: constraints.maxHeight * .1,
                decoration:
                    const BoxDecoration(color: Colors.green, boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(0, 10),
                    blurRadius: 10,
                  )
                ]),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: constraints.maxHeight * .1,
                decoration: const BoxDecoration(color: Colors.red, boxShadow: [
                  BoxShadow(
                    color: Colors.black87,
                    offset: Offset(0, -10),
                    blurRadius: 10,
                  )
                ]),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: constraints.maxHeight * .8 - 20, //remove shadow area
                child: ListView(
                  children: List.generate(
                      44,
                      (index) => Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            height: 70,
                            color: index.isEven
                                ? Colors.deepPurple
                                : Colors.cyanAccent,
                          )),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
