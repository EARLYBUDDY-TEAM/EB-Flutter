import 'package:flutter/material.dart';

class WaveBackground extends StatelessWidget {
  WaveBackground({super.key});

  final Container container = Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blue.shade900, Colors.blue.shade600],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: WaveClipper(),
      clipBehavior: Clip.hardEdge,
      child: container,
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height / 3);
    var firstControlPoint = Offset(size.width / 4, size.height / 2.5);
    var firstEndPoint = Offset(size.width / 2, size.height / 2.5 - 60);
    var secondControlPoint =
        Offset(size.width - (size.width / 4), size.height / 2.5 - 120);
    var secondEndPoint = Offset(size.width, size.height / 2.5 - 80);

    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
